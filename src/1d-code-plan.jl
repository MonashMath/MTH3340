# Key comments on the implementation of the 1D solver

# Structure the code using structs (with their own constructors and associated methods)

# Which structs do we need?

# 1. Mesh representation

# Compute the mesh for a domain (a,b), N cells, uniform 1d mesh constructor

struct Mesh
   nodes_coordinates # Returns the nodes coordinates for a given cell
   cell_nodes        # Returns the nodes global Id for a given cell
end

function Mesh(a,b,N)
  # here the code that computes the mesh
  return Mesh(nodes_coordinates,cell_nodes)
end


# Here, you could create methods (API) like 
# get_nodes_coordinates(::mesh) 
# get_cell_nodes(::mesh)
# but not strictly required (even though good practise)

get_cell_nodes #...
get_node_coordinates #...

# Quadrature (in the reference cell)
# you can build the Quadrature using Julia package for Gauss quadrature 
# e.g., FastGaussQuadratures

struct Quadrature
  points
  weights
end

# and create a (trivial) API

get_integration_points #...
get_weights #...


function Quadrature(degree)
  # determine points needed given a quadrature
  # use existing package
  # call default constructor 
end

# RefFE 

# Create a 1D reference FE space in [-1,1] for an arbitrary order p

struct RefFE
  shape_functions::Vector{Function}
  gradient_shape_functions::Vector{Function}
end

# Here you have two options. 1) Use Lagrangian polynomials or 
# 2) a change of basis and a monomial prebasis.
# 1) is easier in this case, but not as general as 2).

# Create RefFE constructor for order p

function RefFE(p)
  # Use Lagrangian polynomials for given p
  # call default constructor
end

# Geometrical map 

# Here, you will create the geometrical map, which is a cell-wise polynomial.
# It maps your cell I [x_i,x_i+1] onto [-1,1] using a linear polynomial.
# It can readily be defined using scalar first order shape functions from a
# reference FE just constructed (see the lecture notes).

struct GeoMap
  maps::Array{Function}
  jacobian::Array{Function}
end

function GeoMap(mesh::Mesh)
  # Use a linear RefFE to describe the geomap (see lecture notes)

  # Combine the mesh coordinates with the shape functions (map)
   
  # Combine the mesh coordinates with the gradient shape functions (Jacobian)
   
  # Do this for each cell in the mesh and
  # return a cell array with the maps and Jacobians
end

function get_cell_jacobian(gm::geomap)
   return geomap.jacobian
end

# FE Space 

# This struct starts getting a little bit complicated. As we know,
# the global FE space requires the mesh, the reference FE, a 
# local-to-global index map for assembly, and it also needs to know
# whether a node is fixed or free.

# In this work, we assume that the whole boundary, i.e., x = a and b,
# is of Dirichlet type. In order to distinguish between free and fixed
# dofs, we can use the following. We enumerate fixed nodes with 
# -1, -2, ... and free dofs with 1, 2, ... Store this local-to-global
# map (for both free and fixed dofs), in a vector. At each cell, you can
# extract the nodes (from the mesh), and access that vector in the 
# corresponding positions to get the local-global index at the cell
# level. You can alternatively just create the cell-wise local-global
# vector of vectors.
# For the fixed nodes, you have to store the values to be fixed.

struct FESpace 
  mesh::Mesh
  reffe::RefFE
  node_map::Array # local to global map
  fixed_values # e.g, a vector with values at the Dirichlet nodes 
end

function FESpace(mesh,reffe,uD) 
   # uD is a function such that uD(a) = ua, uD(b) = ub
  # extract the boundary nodes and evaluate uD in this nodes to get the fixed_values
  # create the local to global Dof map (see lecture notes) 
  # use the default constructor
end

# Implement the solver function 

# Initialise the local matrices/vectors
# initialise the global matrix
# for K in cells of the mesh
#   for i,j in local cell dofs
#     for gp in integration points
#       A_K[i,j] += # here the expression for the Laplacian
#       Idem forcing term and offset function term 
#     end
#   end
#   Assemble the matrix
# end
#
# uf = A \ f

# Check machine precission error for solution in FE space (method of manufactured solutions) 
# Compute L2 and H1 error and check convergence 

