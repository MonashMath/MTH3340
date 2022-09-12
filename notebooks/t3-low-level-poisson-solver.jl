# This assignment is an introduction to finite element (FE) programming. A FE code is in general much more complex than a finite difference code, because it must be far more flexible. We can deal with complex geometries defined in terms of unstructured meshes, use numerical integration, implement bases of functions with arbitrary orders, etc. To start from scratch a FE code is probably too much, given the time constraints, so we will rely on an existing code to generate some of the information that we need to code our solver. We will use the `Gridap` library

# https://github.com/gridap/Gridap.jl

# It is not the aim of this tutorial to learn how to use `Gridap`, even though we have an excellent set of tutorials that you can read and follow if you like

# https://gridap.github.io/Tutorials/dev/l

# In particular, I have created the simplest possible driver in `t1-gridap-poisson.jl` that you could run and try to connect to what you have learned from the lectures. I recommend to read this tutorial before going further.

# First, we will create the problem we want to solve using `Gridap`, next I will explain you what we want to extract from `Gridap` in order to implement our solver. The interesting part starts there. With some basic data (geometry, shape functions, integration points), we are going to implement a FE solver in a bunch of lines of code. I think that this is going to be a great complement to the lecture notes, since you will see in practise all what we have been describing in the notes.

# `Gridap` is written in `Julia`. Why `Julia`? Because it is easy to use (you do not precompile, like in C, C++ or Fortran) but it is so fast (unlike Matlab and Python). `Julia` is a new programming language, started at MIT in 2011. If you like programming and you are interested in computational and data science, it is something to put in the list of things to learn.

# We will use a very minimal set of `Julia` that will allow us to write the code. If you know Python or Matlab, it should be easy for you to grasp the details. In any case, `Julia` has an amazing documentation

# https://docs.julialang.org/en/v1/

# The most important things you need to know are (1) the basic use of dot syntax for vectorizing functions (https://docs.julialang.org/en/v1/manual/functions/#man-vectorized),

# julia> A = [1.0, 2.0, 3.0]
# 3-element Vector{Float64}:
#  1.0
#  2.0
#  3.0

# julia> sin.(A)
# 3-element Vector{Float64}:
#  0.8414709848078965
#  0.9092974268256817
#  0.1411200080598672

# (2) `map` for applying functions over input collections to generate output collections defined as the result of applying the function element by element to the input collection  (# https://docs.julialang.org/en/v1/base/collections/#Iterable-Collections)

# julia> map(x -> x * 2, [1, 2, 3])
# 3-element Vector{Int64}:
#  2
#  4
#  6
# julia> map(+, [1, 2, 3], [10, 20, 30])
# 3-element Vector{Int64}:
#  11
#  22
#  33

# and (3) a do-block expression of a map, which is just a way to define a map in which the function to be applied to the array(s) (first argument of `map`) is provided at the end using a do-end block:

# julia> map([1, 2, 3]) do x
#            x * 2
#            end
# 3-element Vector{Int64}:
#  2
#  4
#  6
# julia> map([1, 2, 3], [10, 20, 30]) do x, y
#             x+y
#             end
# 3-element Vector{Int64}:
#  11
#  22
#  33


# Just a disclaimer. The code we are going to write is not efficient (we are allocating much more memory than needed and we are e.g. using dense linear algebra). You would never use dense algebra in a performant FE solver. However, I think that these issues are not important here at all. If you want to see a low-level driver that is highly efficient, using the `Gridap` machinery, you can take a look here:

# https://gridap.github.io/Tutorials/dev/pages/t012_poisson_dev_fe/#Tutorial-12:-Low-level-API-Poisson-equation-1

# but this is very advanced stuff that is completely out of the scope of this unit.

# Let us start with the tutorial!

# # Part 1: Defining the problem using Gridap

# Let us start using Gridap. The following line activates `Gridap` in our Julia session, and thus, we can now start running the code below.

using Gridap
using Gridap.ReferenceFEs
using Gridap.Geometry
using Gridap.CellData

# Here we define the problem we want to solve using Gridap. We are not interested in knowing how Gridap works or its interfaces. We are going to use some of the information created in Gridap to implement our finite element code for solving the Poisson equation.

# First we define the geometry of the problem at hand, a D-cube [0,L]^D and the uniform partition into n^D cells. For example, for D=2, L=1, and n=4, we would create a uniform partition with 4x4 cells of a 2-cube (i.e., a square). You can change D, e.g., 1 or 2 or 3 or whatever you like. The code is written in such a way that is dim-agnostic.

L = 1 # Domain length in each space dimension
D = 1 # Number of spatial dimensions
n = 4 # Partition (i.e., number of cells per space dimension)

pmin = Point(fill(0,D)) # Bounding box: Origin (0,0) in 2D
pmax = Point(fill(L,D)) # Bounding box: End, e.g., (L,L) in 2D
partition = Tuple(fill(n,D)) # Partition, e.g., (n,n) in 2D

model = CartesianDiscreteModel(pmin,pmax,partition)

# Let us assume that we want to create a problem with solution

u(x) = x[1]            # Analytical solution u(x)=x (for Dirichlet data)
#

# We can use `Gridap` to compute differential operators over functions, e.g., its gradient.

∇u = ∇(u)

# Thus, the forcing term in order for this solution to be true must be

f(x) = -Δ(u)(x)        # Body force such that -Δu = f

# Now, we create the reference FE space for our unknown uh. Since we solve the scalar Poisson problem (which represents, e.g., temperature conduction), our FE space is scalar.

T = Float64 # Our unknown is a scalar field
order = 3 # Order of approximation for the unknown
pol = Polytope(fill(HEX_AXIS,D)...) # Segment in 1D, Square in 2D ...
reffe = LagrangianRefFE(T,pol,order)

# With the reference FE, the geometry, and the Dirichlet boundary (we assume here that all the boundary is of Dirichlet type), we can create our FE space. H1 conformity means that we want to create a Lagrangian C0 space, as the one explained in the notes. We define first the space of test functions, which vanish at the boundary.

Vh = FESpace(model,reffe;conformity=:H1,dirichlet_tags="boundary")

# The trial space differs (in general, for Galerkin methods) from the test space due to the Dirichlet boundary conditions. We enforce the boundary conditions using the analytical function `u` in our manufactured solution.

Uh = TrialFESpace(Vh,u)

# Now, we can create FE functions, e.g., by interpolating the analytical solution onto the FE space.

uh = interpolate(u,Uh)

# Since we want to use a FE approximation of the Poisson equation, we will need to integrate mass and right-hand side terms. For that, we use numerical integration using a Gauss quadrature. We will also need some geometrical information of the geometrical model (e.g., cell nodes). The second argument in `CellQuadrature` is its degree, the order of polynomials that can be integrated exactly in each direction. We have taken a degree that is more than what we will need.

Th = Triangulation(model)
Qh = CellQuadrature(Th,4*order)

# In order to create the geometrical map from the reference to the physical space, we make use of a __linear__ Lagrangian FE space.

reffe_g = LagrangianRefFE(Float64,pol,1)

# # Part 2: Extracting the essential info from Gridap

# Now, we are going to extract the key information generated by Gridap above that we will need to implement our FE code.

# First, we obtain the arrays of integration points (coordinates and weights) in our cells.

cell_ips = collect(map(a -> get_coordinates(a), get_data(Qh))) # int points per cell
cell_ws = collect(map(a -> get_weights(a), get_data(Qh))) # weights per cell

# Next, we extract the shape functions in each cell (in the reference space), for both the trial and test space (we use a Galerkin formulation).

# The reference finite element provides the basis of shape functions and their gradients.

ϕ = get_shapefuns(reffe)
∇ϕ = ∇.(get_shapefuns(reffe)) # Shape function gradients

# Idem for the reference FE being used for the geometry map (which are identical for linear FE spaces for the unknown).

ϕgeo = get_shapefuns(reffe_g)
∇ϕgeo = ∇.(get_shapefuns(reffe_g))

# Each basis is a set of functions that can be evaluated in a set of points.
evaluate(ϕ,[Point(fill(0.0,D)),Point(fill(0.5,D)),Point(fill(1.0,D))])
evaluate(∇ϕ,[Point(fill(0.0,D)),Point(fill(0.5,D)),Point(fill(1.0,D))])

# The first index in the resulting matrix is the point in the array of points while the second index is the shape function number. You can also extract one function of the basis and evaluate it individually.
evaluate(ϕ[1],[Point(fill(0.0,D)),Point(fill(0.5,D)),Point(fill(1.0,D))])
evaluate(∇ϕ[1],[Point(fill(0.0,D)),Point(fill(0.5,D)),Point(fill(1.0,D))])

# In fact, the only thing we will need is the evaluation of the shape functions in the integration points. We note that both the integration points and the shape functions are in the reference space.

# The FE space provides the DOF IDs per cell. We use positive values for free DOFs and negative values for fixed DOFs, a very common trick in FE codes.

cell_dofs = get_cell_dof_ids(Uh)

# The test space also provides the fixed Dirichlet values on the boundary nodes.
fixed_dof_values = get_dirichlet_values(Uh)

# For a given FE function in this space, one can extract the array of free values.

free_dof_values = get_free_values(uh)

# Now, we extract some geometrical information from the triangulation. From one side, we extract the global numbering of nodes and the array of coordinates.

cell_node_ids = get_cell_node_ids(Th) # Using Cartesian indices
cell_node_ids = collect(reshape(cell_node_ids,length(cell_node_ids))) # Linear indices
X = get_node_coordinates(Th) # Using Cartesian indices
X = collect(reshape(X,length(X))) # Linear indices

# Recapping, we have collected the following information from Gridap: (1) mesh info: the local-to-global node numbering `cell_node_ids` and vertices (nodes) coordinates `X`; (2) quadrature info: integration points `cell_ips` and weights `cell_ws`; (3) Reference FE info: the basis of shape functions `ϕ` and their gradients `∇ϕ` (idem for the geometry interpolation, which is assumed to be linear, `ϕgeo` and `∇ϕgeo`), and the `evaluate` function that evaluates these functions in a set of points per cell; (4) FE space info: the local-to-global numbering `cell_dofs`, an array with Dirichlet DOFs values `fixed_dof_values`; (5) FE function info: an array with the free DOFs values `free_dof_values`.

# Part 3: Our FE Poisson solver implementation

# With all these ingredients, we can implement our finite element code, which will solve the Poisson equation.

# Let us evaluate the shape functions and their gradients in all integration points. Since in our simple solver all reference FEs are the same and we use the same integration points in all cells, we can compute it only once.

# Evaluate ref FE shape functions in integration points.

ips = cell_ips[1]
ϕ_gp = evaluate(ϕ,ips)
∇ϕ_gp = evaluate(∇ϕ,ips)

# We can do the same for the geometry map shape functions.

ϕgeo_gp = evaluate(ϕgeo,ips)
∇ϕgeo_gp = evaluate(∇ϕgeo,ips)

# Using the cell nodes and the global array of node coordinates, we can compute the cell-wise coordinates.

cell_X = map(a->X[a],cell_node_ids)

# A finite element function can easily be obtained with the previous shape functions and arrays. In order to impose the Dirichlet data, we use the offset function method.

zero_vals = zero(free_dof_values)

# Let us define a function that given the arrays of free and fixed DOFs returns a function such that (in one cell) returns the nodal values of the FE function for a given DOF `i`. If `i` is a free DOF (i.e., if `i>0`), it takes the value from the array of free DOFs, otherwise from the one of fixed DOFs.

extract_vals(free_vs,fixed_vs) = i -> i>0 ? free_vs[i] : fixed_vs[-i]

# With this, we can obtain the nodal values of the offset function in each cell, and evaluate the function at nodal values.

evs = extract_vals(zero_vals,fixed_dof_values)
cell_u0_nodes = map(a->evs.(a),cell_dofs)
cell_u0_gps = map(a -> ϕ_gp*a,cell_u0_nodes)


# The array cell_u0_gps[icell][jgp] is indexed for each cell first and for each integration point next.

# Idem for its gradients (in the reference space!).

cell_∇u0_gps = map(a -> ∇ϕ_gp*a,cell_u0_nodes)

# The array cell_∇u_gps[icell][jgp] is indexed for each cell first and for each integration point next. It returns a vector (called `VectorValue` in Gridap) which can be accessed in its different components as an array.

cell_∇u0_gps[1][1]
cell_∇u0_gps[1][1][1]

# The geometrical map is nothing but a linear FE function with nodal values the
# coordinates of the problem. This array provides for each cell the integration points in the physical space, which we will use later on.

geomap_gp = map(a -> ϕgeo_gp*a, cell_X)

# The Jacobian is just the gradient of this (vector-valued) function. In order to explain how we compute it, let us provide some details. First, the gradient of shape functions `∇ϕgeo_gp` is a 2-array, with first index being the integration point and second the shape function number. It returns a vector (even though in 1D a vector is just one number). `cell_X` is a cell-wise array, and in each cell it returns a 1-array of vectors (the coordinates, again just one number in 1D). The Jacobian matrix is a tensor, and is mathematically computed as J_ij = ∂(x_i)/∂(X_j) (x denotes physical space and X reference space). On the other hand, x(X) = ∑_a ϕ_a X_a (a denotes the index of the node in the reference FE space). Combining this, J_ij = ∑_a ∂(ϕ_a)/∂(X_j) X_a[i] (we note that we are using a scalar basis and vector DOF values here, e.g., ϕ is scalar and X_a is a vector). Another way to write this is J_ij = ∑_a X_a ⊗ ∇ϕ_a, where ⊗ is the outer vector product, i.e., (a⊗b)_ij = a_i*b_j:

# julia> a = VectorValue(1.0,2.0)
# VectorValue{2,Float64}(1.0, 2.0)

# julia> b = VectorValue(3.0,4.0)
# VectorValue{2,Float64}(3.0, 4.0)

# julia> ab = outer(a,b) # or ab = a ⊗ b
# TensorValue{2,2,Float64,4}(3.0, 6.0, 4.0, 8.0)

# julia> get_array(ab)
# 2×2 StaticArrays.SArray{Tuple{2,2},Float64,2,4} with indices SOneTo(2)×SOneTo(2):
# 3.0  4.0
# 6.0  8.0

# We can do all this in a VERY compact way using `Julia`.

∇geomap_gp = map(cell_X) do Xk # apply the following block to each entry of cell_X (cell loop)
  map(eachrow(∇ϕgeo_gp)) do grad # apply the following block to each row of `∇ϕgeo_gp` (gp loop)
     sum(outer.(Xk,grad)) # ∑_a X_a⊗∇ϕ_a
  end
end

# Now, we compute the ingredients we need for gradients in the physical space.

inv_Jt_gps = map(j->transpose.(inv.(j)),∇geomap_gp)
det_J_gps = map(j->det.(j),∇geomap_gp)

# Now, we can compute the gradients in the physical space. (The ⋅ operator is the inner product defined in Gridap for vectors.)

∇ϕ_gp_phys = map(a->a.⋅∇ϕ_gp,inv_Jt_gps)

# Using a linear combination, we can evaluate the offset function gradient.

∇u0_gps = map((a,b) -> a*b, ∇ϕ_gp_phys, cell_u0_nodes )

# This is used to compute the right-hand side, which simply reads - ∫ ∇u0 ⋅ ∇v . The residual is an array of cell-wise residuals (not yet assembled).

# We compute the value of the gradient of the offset function times the determinant of the Jacobian times the weight for all integration points

cell_∇u0_w_j = map((a,b,c)->a.*b.*c,cell_ws,det_J_gps,∇u0_gps)

# Now, we extract gradients of shape functions and multiply with the previous value

res = map(∇ϕ_gp_phys,cell_∇u0_w_j) do grad_gp, ∇u0_w_j
  map(eachcol(grad_gp)) do gr # extract each shape function gradient at the integration points
    -1*sum(gr.⋅∇u0_w_j)
  end
end

# Now, we can create a function that assembles the cell-wise residuals.

function assemble_rhs!(rhs_assembled,cell_rhs)
  for (ipn,rk) in zip(cell_dofs,cell_rhs)
    for (ig,rkv) in zip(ipn,rk)
      if ig > 0
        rhs_assembled[ig] += rkv
      end
    end
  end
end

# Here we use this function to assemble the residual.

rhs = zero(free_dof_values)
assemble_rhs!(rhs,res)
# print(rhs)

# Now, we calculate the system matrix, which reads ∫ ∇u ⋅ ∇v . As above, `mat` is the array of cell matrices, not yet assembled.

cell_mat = map(∇ϕ_gp_phys,cell_ws,det_J_gps) do a,ws,js
  b = zero(broadcast(⋅,transpose(a[1,:]),a[1,:]))
  for igp = 1:size(a,1)
    b += ws[igp]*js[igp]*broadcast(⋅,transpose(a[igp,:]),a[igp,:])
  end
  return b
end

# print(cell_mat)

# Analogously, we create the assembly function for the system matrix.

function assemble_mat!(A,cell_A)
  for (ipn,Ak) in zip(cell_dofs,cell_A)
    for (il,ig) in enumerate(ipn)
      if ig > 0
        for (jl,jg) in enumerate(ipn)
          if jg > 0
            # print(ig,jg)
            A[ig,jg] += Ak[il,jl]
          end
        end
      end
    end
  end
end

# With this function, we initialize to zero the system matrix and assemble the local contributions using the previous function.

l = length(free_dof_values)
mat = zeros(l,l)
assemble_mat!(mat,cell_mat)

# print(mat)

# Now, we solve the system and get the free values of the FEM solution.

sol_free_dofs = mat \ rhs

# As above, using the fixed DOFs from the Dirichlet values (the offset function) and the obtained free values, we get the final solution, which we can evaluate e.g. in integration points.

evs = extract_vals(sol_free_dofs,fixed_dof_values)
cell_u_nodes = map(a->evs.(a),cell_dofs)
cell_u_gps = map(a -> ϕ_gp*a,cell_u_nodes)

# Now, we want to integrate the L2 error of the solution using our quadrature. We can do that as follows. The function `u` provides the analytical solution in the physical space. We want to integrate the error in integration points. We thus want to evaluate the solution in the physical space. But the integration points are in the reference space. Thus, we should map the integration points from the reference to the physical space and evaluate `u` on them.

# First, we move the points from the reference to the physical space. In fact, we have already computed this value in `geomap_gp`. We apply the function `u` cellwise to all these points, and extract the exact and computed solution at these points. Thus, we have the error at all integration points of all cells, which is what we will need to compute the L2 error.

cell_uex_gps = map(a->u.(a),geomap_gp)
cell_e_gps = map((a,b) -> a-b, cell_uex_gps, cell_u_gps)
cell_e2_gps = map(a->a.*a,cell_e_gps)


# Now, we integrate the error at all cells.
cell_eL2 = map(cell_e2_gps, cell_ws, det_J_gps) do es, ws, js
  sum(es.*ws.*js)
end

# And we sum the integrals at all cells to get the global error.

e_L2 = sum(cell_eL2)

print("The L2 error is: ",e_L2)

# Now, you are ready to proceed to the practical assignment in `assignment.jl`. You can write the code in this file and submit the `.jl` file in the Moodle page.
