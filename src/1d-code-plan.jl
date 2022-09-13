# Key comments on the implementation of the 1D solver

# Structure the code using structs (with their own constructors and associated methods)

# Which structs do we need?

# Mesh representation

struct Mesh
   nodes_coordinates
   cell_nodes
end

# domain (a,b), N cells, uniform 1d mesh constructor

function Mesh(a,b,N)
  ...
  return Mesh(nodes_coordinates,cell_nodes)
end

get_cell_nodes = ...
get_node_coordinates = ...

# Quadrature (in the reference cell)

struct Quadrature
  points
  weights
end

# you can build the Quadrature using Julia package for Gauss quadrature 

function Quadrature(degree)
  # determine points needed given a quadrature
  # use existing package
  # call default constructor 
end

# RefFE 

struct RefFE
  shape_functions::Vector{Function}
  gradient_shape_functions::Vector{Function}
end

# Create RefFE constructor for order p

function RefFE(p)
  # Use Lagrangian polynomials for given p
  # call default constructor
end

# Geometrical map 

struct GeoMap
  mesh::Mesh
  ref_febasis::RefFE
end

# Geometrical map from reference to physical cell

function GeoMap(mesh::Mesh)
  # Use a linear RefFE to describe the geomap (see lecture notes)
end

function get_cell_jacobian(gm::geomap)
  # Combine the mesh coordinates with gradient shape functions
  # Do this for each cell in the mesh
  # return a cell array
end

# FE Space 

struct FESpace 
  mesh::Mesh
  reffe::RefFE
  fixed_values # e.g, a vector with values at the Dirichlet nodes 
  cell_dofs
end


function FESpace(mesh,reffe,uD) # uD is a function such that uD(a) = ua, uD(b) = ub
  # extract the boundary nodes and evaluate uD in this nodes to get the fixed_values
  # create the local to global Dof map (see lecture notes) 
  # To deal with Dirichlet nodes, we usually put negative indices for nodes that are Dirichlet
  # and positive index for those that are free, this way, we can check whether a node is Dirichlet
  # or not in the loop below.
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

