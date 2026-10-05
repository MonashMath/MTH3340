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
# get_node_coordinates(::Mesh)
# get_cell_nodes(::Mesh)
# num_cells(::Mesh)
# but not strictly required (even though good practise). The idea is that
# the rest of the code only uses these methods, never the fields.

get_node_coordinates(m::Mesh) = m.nodes_coordinates
get_cell_nodes(m::Mesh) = m.cell_nodes
num_cells(m::Mesh) = length(m.cell_nodes)

# Quadrature (in the reference cell)
# you can build the Quadrature using Julia package for Gauss quadrature 
# e.g., FastGaussQuadratures

struct Quadrature
  points
  weights
end

# and create a (trivial) API

get_integration_points(q::Quadrature) = q.points
get_weights(q::Quadrature) = q.weights
num_points(q::Quadrature) = length(q.points)


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
# 1) is easier in this case, but not as general as 2). We use 1):
# with nodes x_1 = -1 < ... < x_{p+1} = 1 (equispaced),
#   phi_i(x)  = prod_{j != i} (x - x_j)/(x_i - x_j)
#   phi_i'(x) = sum_{k != i} 1/(x_i - x_k) prod_{j != i,k} (x - x_j)/(x_i - x_j)
# Both fields are vectors of functions (a function can return a function:
# lagrange(i) = x -> ... gives the i-th shape function).

# Create RefFE constructor for order p

function RefFE(p)
  # Use Lagrangian polynomials for given p
  # call default constructor
end

# API
get_shape_functions(r::RefFE) = r.shape_functions
get_gradient_shape_functions(r::RefFE) = r.gradient_shape_functions
num_dofs(r::RefFE) = length(r.shape_functions)

# Geometrical map 

# Here, you will create the geometrical map, which is a cell-wise polynomial.
# It maps [-1,1] onto your cell K = [x[i], x[i+1]] using a linear polynomial.
# It can readily be defined using scalar first order shape functions from a
# reference FE just constructed (see the lecture notes):
#   Phi_K(xhat) = sum_i x_K^i phi_i(xhat),   J_K(xhat) = sum_i x_K^i phi_i'(xhat)
# Again two vectors of functions, one entry per cell: maps[K] is the linear
# combination of the two linear shape functions with the vertex coordinates
# of K as coefficients (idem the Jacobian with the derivatives).

struct GeoMap
  maps::Vector{Function}
  jacobian::Vector{Function}
end

function GeoMap(mesh::Mesh)
  # Use a linear RefFE to describe the geomap (see lecture notes)

  # Combine the mesh coordinates with the shape functions (map)

  # Combine the mesh coordinates with the gradient shape functions (Jacobian)

  # Do this for each cell in the mesh and
  # return a cell array with the maps and Jacobians
end

# API
get_cell_map(gm::GeoMap) = gm.maps
get_cell_jacobian(gm::GeoMap) = gm.jacobian

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
  # evaluate uD at a and b to get the fixed_values
  # create the local to global DOF map (see lecture notes). Careful: a vertex
  # shared by two cells must receive the same global id from both cells.
  # For p > 1, cell K owns the p+1 global nodes (K-1)p+1, ..., (K-1)p+p+1
  # (consecutive cells share the interface node); in total N*p+1 nodes, the
  # two end nodes fixed, the other N*p-1 free. No node coordinates are needed.
  # use the default constructor
end

# API
get_cell_dofs(V::FESpace) = V.node_map      # cell-wise local-to-global map
get_fixed_values(V::FESpace) = V.fixed_values
num_free_dofs #...

# Implement the solver function

# Initialise the local matrices/vectors
# initialise the global matrix
# for K in cells of the mesh
#   for gp in integration points
#     for i,j in local cell dofs
#       A_K[i,j] += # here the expression for the Laplacian
#       Idem forcing term and offset function term
#     end
#   end
#   Assemble the matrix (and vector) using the local-to-global map of K.
#   When the global index of a local dof is negative (fixed), the column of
#   A_K multiplies a known value and goes to the right-hand side (offset term).
# end
#
# uf = A \ b

# FE function

# After solving, uf contains only the FREE dof values. To evaluate the FE
# function (errors, plots) we need a function of the FE space, i.e., the space
# plus the vector of free values; the fixed values (and the local-to-global
# map) already live in the space.

struct FEFunction
  space::FESpace
  free_values
end

# Methods, each returning one entry per cell K:
#   get_cell_values(uh)    -> [u_lg(1,K), ..., u_lg(p+1,K)], where u_a is
#                             free_values[a] if a > 0 and fixed_values[-a] if a < 0
#   get_cell_functions(uh) -> xhat -> sum_alpha u_lg(alpha,K) * phi_alpha(xhat)
# (the restriction of u_h to K, in the reference coordinate; for the H1 error
# you also need the derivative, phi_alpha' / J_K)
get_cell_values #...
get_cell_functions #...

# To plot u_h or compute pointwise errors we also want to evaluate it at
# arbitrary physical points:
#   evaluate(uh, points) -> [u_h(x) for x in points]
# For each x: find the cell K that contains it (easy for a uniform mesh), map
# it back to the reference cell, xhat = Phi_K^{-1}(x) (Phi_K is linear, invert
# it by hand), and evaluate the cell function of K at xhat.
evaluate #...

# Check machine precission error for solution in FE space (method of manufactured solutions)
# Compute L2 and H1 error and check convergence (cell by cell, with a quadrature
# of higher degree than the one used for assembly: the error is not a polynomial)

