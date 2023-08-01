### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 35d934a8-5ed4-4578-a2ba-d2fbd494ba7e
using Gridap

# ╔═╡ 48deba06-8334-47d4-a369-17521d804580
a = 5+3

# ╔═╡ 0103b36e-dcbb-4774-bf94-9bebff55bf76
typeof(a)

# ╔═╡ 6547039b-1c87-4ef9-b2ad-2a84a038727c
b = "Hello"

# ╔═╡ 76f68199-b3be-43a6-9ea7-a4b6ff541b68
typeof(b)

# ╔═╡ 84dbb3b4-8bec-4b45-b4b3-935e5853dabb
# Run these lines in a Julia REPL
# > using AbstractTrees
# > AbstractTrees.children(d::DataType) = subtypes(d)
# > print_tree(Number)

# ╔═╡ 2c2e3204-7d75-4dc7-9f48-368455b8a200
Float64(5)

# ╔═╡ b5457c56-ff7f-4aa3-9427-8bfbdf4e06ff
Int64(3.0)

# ╔═╡ 0e2154f2-3982-4efb-8e7c-e6666316cd92
Int64(7.6)

# ╔═╡ 8367bf4c-90b5-4a94-82df-72b557f0129e
floor(Int64,7.6)

# ╔═╡ 8e93d3d1-015b-429c-92d6-ce397eecf24d
ceil(Int64,7.6)

# ╔═╡ 264f3c25-5e23-44bd-8354-37cd8d82bf0f
Float64("hello")

# ╔═╡ 5febcf2a-0ca4-40b4-b662-8628b91247f2
f(x) = x^2

# ╔═╡ 634967ec-5ef2-452b-bef0-72bac47cbb3c
f(2)

# ╔═╡ 50b06284-59bd-45f5-ab34-cfe03e1f91eb
f(1.5)

# ╔═╡ 13127cbf-857c-4a9b-8df8-bade87cb471d
f([1 0; 0 2])

# ╔═╡ d6b1a809-9a7e-459f-a032-02b982d941a9
nice_sum(a::Real,b::Real) = "The sum of these two Float64 numbers is $(a+b)"

# ╔═╡ b74cb151-adcf-46b3-a635-ae965f9a72cd
nice_sum(1.0,2.0) # We have not implemented this! Why does it work? (see the Real tree)

# ╔═╡ 612baddc-f4b8-4599-8f8e-4bcc22205b04
nice_sum(3,4) # We have not implemented this! Why does it work? (see the Real tree)

# ╔═╡ 2607d711-f312-4574-bd3c-8ae3f43e8431
nice_product(a::Float64,b::Float64) = "The product of these two Float64 is $(a*b)"

# ╔═╡ 60eaabfd-716c-44f9-8a5d-2336f7f9a931
nice_product(1.0,3.0) # Default is Float64

# ╔═╡ 70eab5c5-9640-4e07-8de2-e0b875298fad
nice_product(1,3) # Why this is not working? (check the Real tree again)

# ╔═╡ 3fd17a38-cfeb-464a-be2b-8d11f64230b9
nice_division(a::Int,b::Int) = "The quotient of these two Integer numbers is $(a/b)"

# ╔═╡ 3c1c797f-a436-4144-9134-a76b92459cda
nice_division(a::Real,b::Real) = "The quotient of these two Real numbers is $(a/b)"

# ╔═╡ cbec6d57-8e3c-41bd-9bff-0bd871facd50
nice_division(a::Int,b::Real) = "The quotient of these Integer and Real numbers is $(a/b)"

# ╔═╡ 08d241f3-bff1-4aa7-bd0a-bf7721731ecf
nice_division(a::Real,b::Int) = "The quotient of these Real and Integer numbers is $(a/b)"

# ╔═╡ d7f3774b-2a96-49b4-b0e3-1d8ee564ac2e
nice_division(1,3)

# ╔═╡ 4d94451f-b697-4d03-9ab9-98445f42b9e0
nice_division(0.5,6.7)

# ╔═╡ 1eb31813-c3a6-4d3b-a299-0372ce5057a9
nice_division(3,4.5)

# ╔═╡ 1e239a27-d73d-4327-ad34-cd0d3f4aeb1f
nice_division(4.5,3)

# ╔═╡ 8c8e8d3e-5416-4a8a-811b-6c9042ad9f77
struct ExponentialDiagonalVector1
	r
	d::Int
end

# ╔═╡ 3ae90d7b-a168-4bb7-9da0-9f3c3be1db14
A = ExponentialDiagonalVector1(3.0,2)

# ╔═╡ 418b0774-50fd-4afc-89d8-11b3a69eb136
typeof(A)

# ╔═╡ 853c10b8-f270-4bf9-9334-5c0fc555562a
struct ExponentialDiagonalVector2{T<:Number}
	r::T
	d::Int
end

# ╔═╡ 8afeef64-3d28-4175-ad84-87ddc6bd6d0c
begin 
# begin end are only needed for Pluto (to include more than one instruction in a cell)
  B = ExponentialDiagonalVector2(4.0,5)
  C = ExponentialDiagonalVector2(6,5)
end

# ╔═╡ 6cb426c1-a002-4c0b-a6be-185999bdc635
typeof(B)

# ╔═╡ 81d604b5-6424-4e25-9116-5a3507a937a0
typeof(C)

# ╔═╡ 9fcbf35e-a5a7-4a0e-94ee-97697c083575
struct ExponentialDiagonalVector3{T} <: AbstractVector{T} # or AbstractArray{T,1}
	r::T
	d::Int
end

# ╔═╡ b5362538-64ad-4d60-8e40-aef9c3feb694
begin 
    Base.size(A::ExponentialDiagonalVector3) = (A.d,A.d)
	Base.IndexStyle(::Type{ExponentialDiagonalVector3}) = IndexLinear()
	Base.getindex(A::ExponentialDiagonalVector3,i::Int) = A.r^i  
end

# ╔═╡ 8e25ccb7-7b49-4e9d-90e5-ad4de5473465
md"# Introduction to Julia

In this tutorial, we will learn the basics of `Julia`. We can run this tutorial from VSCode, using the REPL, or as a Pluto notebook.
"

# ╔═╡ 04aeddda-2ff7-11ee-3a5e-8bb3ef0ba8df
md"## Installing packages

The `Julia` package manager is simply great. You can easily install `Julia` packages included in the `Julia` registry from the REPL. Below, we are importing and installing `Gridap`, the finite element code we are going to use in some of the lectures.
"

# ╔═╡ 93df5d91-a432-402d-b85c-56395fb67750
md"## Basic variables

`Julia` is the choice for this unit for a very simple reason. It is easy to use and can be very fast. The typical motto is _walks like Python, runs like C_. It means that you can easily prototype codes like in an *interpreted language* (like Python). There is no need to type each and every variable you aim to use in a header, as one does in *compiled* languages like C, C++ or FORTRAN. We call this way of coding _duck typing_. As soon as the code _makes sense_ (e.g., you cannot compute the absolute value of a string), you don't need to explicitly provide the type of your variables.
"

# ╔═╡ 4f6cfa6b-0b0b-49e3-ae5c-fe44653eedd5
md"We did not explictly assign a type to these variables, the language did it for us."

# ╔═╡ 9695b546-0bc8-4473-85e0-afb01dc8e60f
md"## The type ecosystem"

# ╔═╡ 5e1c18ef-cd95-4edc-81a6-bf38ec7162c3
md"One of the most important parts to understand when we start working with `Julia` is the *type ecosystem*. We can think of it as a huge tree, the root being the most abstract type and getting more concrete as we go up through the branches. This is called the type hierarchy. For instance, we can see below the portion of the type ecosystem that starts in `Number` (great example for a math unit)."

# ╔═╡ 0282ab96-9f79-4bbc-a817-b28c46f064dd
md"It makes mathematical sense, a rational number is a sub-type of a real number, which is a sub-type of a number."

# ╔═╡ 8f27cc1e-6f03-4f05-b18c-26f61b14629f
md"The type system provides conversions between types (if possible). E.g., we can convert integers to floats. However, we cannot convert a float to an integer (in general)."

# ╔═╡ aab16cc1-830f-4e74-ba9e-f07e78d27001
md" The type ecosystem is dynamic, i.e., you can extend it adding your sub-types. The root of the type system is `Any`. You can see the huge Julia type system by plotting the type tree of `Any`."

# ╔═╡ 05779915-ed1d-4c7e-9058-b645e1d331ba
md"## Multiple dispatching

`Julia` is *not* based on the object-oriented programming language (unlike Python, or C++). If you are expert in OOP, you need to adapt to a new way of thinking. Leaving computer science technicalities aside, the core of `Julia` programming paradigm is *multiple dispatching*. Multiple dispatch provides a mechanism to define a function with different implementations, and to pick the implementation depending on the type of multiple arguments. It is strongly connected to the dynamic type system.

`Julia` also uses many features of `functional` programming. We can declare functions, pass them as arguments of other functions, etc. 

Let us create our first function.
"

# ╔═╡ 72be3410-0152-42b1-8f76-bfc3566ea3a3
md"We can now apply this function to any existing `Julia` existing type for which its square makes sense (and it has been implemented). So, we can apply `f` to any kind of number, matrix, etc."

# ╔═╡ 3ba80192-2368-4e95-b670-fcfac76f58de
md" Internally, Julia is using multiple dispatching to decide whether to use the product of numbers or matrices (totally different implementations). Let us create our own multiple dispatching example.

First, we create a function that adds two Float64 numbers and writes a message"

# ╔═╡ b4eefcb0-9303-4885-b2e1-811573dd184c
md"Let us create another example. We create now `nice_product` for Integer"

# ╔═╡ 669f6613-bd63-4b3d-b3ee-eaf6c67409af
md"Now let us define another method for division, now using (simple) dispatching"

# ╔═╡ bf04e4e0-b6a2-4a20-b164-937d9e0b9577
md"And now examples of multiple dispatching."

# ╔═╡ 40bb892b-249c-4285-8845-3ae5248b80da
md"## Data types

In `Julia`, you can define your own data types and extend the type system. In particular, you can define composite types (`struct`). Combining this dynamic type system with multiple dispatching provides a very extensible and powerful language. 

In `Julia`, all `array` types are sub-types of an abstract type called `AbstractArray`. Let us create a very specific array. Let us consider a vector such that, given a number `r` and a length `D`, has diagonal values `r^1, r^2, ..., r^(D-1)`. We will call this vector type `ExponentialDiagonalVector`. We will create more than one type to learn different important aspects of `struct`. We will call them `ExponentialDiagonalVector1`, `ExponentialDiagonalVector2`,...
"

# ╔═╡ 1d445c8f-7397-4147-bfdd-96c725d9514c
md"We can do better. We can use template parameters. I.e., we can define in one shot so many different types. E.g., a vector can be a vector of reals, integers, etc. With the constructor above, the type `ExponentialDiagonalVector1` does not provide any information about the kind of numbers it stores."

# ╔═╡ 21440601-8708-4920-a6ca-3e30ca325973
md"Here, `T` is the template parameter and `T<:Number` means that `T` must be a sub-type of `Number`. We don't want to create matrices with e.g. strings. Now, let us see what info we get after creating our vector."

# ╔═╡ 6956f1c7-ccbd-44ac-9fb1-4c46e8afda49
md"The type `ExponentialDiagonalVector2{Float64}` tells us that the vector has  `Float64` entries. This type is different from, e.g. `ExponentialDiagonalVector2{Int64}`. So you can define different implementations (e.g., the dot product) for each case and dynamically pick the right implementation using multiple dispatching. Probably, it does not make much sense in this example, but it does in more complex situations.

You can have as many template parameters as you want.

For instance `AbstractArray{T,D}` type in `Julia` has two template parameters, `T` is the type of the array entries and `D` is the dimension of the array (e.g., 1 for vectors and 2 for matrices). An `AbstractVector{T}` is an alias for `AbstractArray{T,1}`.

The possibility of extending existing types in the type system is one of the most powerful features of 'Julia'. It is clear that `ExponentialDiagonalVector2{Float64}` should be a subtype of `AbstractArray{Float64,1}`. We can do that as follows.
"




# ╔═╡ 05e10551-e7cc-4b3f-9321-f58162eed217
md"And now the magic comes. Which are the most basic methods that an array should be able to answer? In other words, which is the _interface_ of `AbstractArray` in `Julia`?

You can find it here: [https://docs.julialang.org/en/v1/manual/interfaces/](https://docs.julialang.org/en/v1/manual/interfaces/)

To understand the interface is too much at this stage. Let us consider the _required_ methods. 
"  

# ╔═╡ 03b2ad88-cf40-4946-901f-89a8af9b57b4
D = ExponentialDiagonalVector3(4.0,3)

# ╔═╡ 9c212c12-2235-4420-af35-5de876325332
getindex(D,5)

# ╔═╡ 53c3011a-9980-434a-960e-8c14fdf81582
size(D)

# ╔═╡ ff9a97e6-1661-4b56-b3af-9fef26ce6a50
dot(D,D)

# ╔═╡ 76d26b37-6f5a-48cb-b136-a22022bf3c39
md"Who implemented the dot product of vectors? The inner product of functions can be implemented for an abstract array just using `size` and `getindex`. In `Julia`, there is an implementation of the dot product for this abstract type. We have created a sub-type of `AbstractVector`. Using multiple dispatch, `Julia` seeks the most _concrete_ `dot` implementation. In this case, since we have not implemented one for `ExponentialDiagonalVector3`, it uses the one for `AbstractVector` in `Julia`.

 Note that `ExponentialDiagonalVector2` is not a sub-type of `AbstractVector`, so we are not able to re-use `Julia` generic code.

You probably see now the potential of this language."

# ╔═╡ ef94bd94-21b7-46a0-8a2d-f857b7a064cd
md"## Just-in-time compilation

Why is `Julia` much faster than `Python`, and as fast as typed (compiled) languages like C?

You have seen that in `Julia` you can write code like in `Python`, without declaring the type of your variables (type annotation). But *you can also annotate the type* if you want. Why would you do this extra work? 

The reason is that `Julia` compiles code on the fly, e.g., in run-time. If you declare the type of a function argument, the compiler can do many optimisations (as in C, FORTRAN,...) and end up with very efficient code.

In `Julia`, you can quickly write a prototypical code (not paying attention to performance, without typing) or write extremely fast code (using type annotation in the right places). To know when you should provide the type is not easy, and requires some understanding on how `Julia` and its JIT compiler work.

In any case, performance is not an issue in this unit."

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Gridap = "56d4f2e9-7ea1-5844-9cf6-b9c51ca7ce8e"

[compat]
Gridap = "~0.17.17"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "aa8478d438bb6e55a3447572680a54de4981a156"

[[deps.AbstractFFTs]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"

[[deps.AbstractTrees]]
git-tree-sha1 = "faa260e4cb5aba097a73fab382dd4b5819d8ec8c"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.4"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "76289dc51920fdc6e0013c872ba9551d54961c24"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.6.2"

[[deps.ArgCheck]]
git-tree-sha1 = "a3a402a35a2f7e0b87828ccabbd5ebfbebe356b4"
uuid = "dce04be8-c92d-5529-be00-80e4d2c0e197"
version = "2.3.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra", "Requires", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "f83ec24f76d4c8f525099b2ac475fc098138ec31"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.4.11"

[[deps.ArrayLayouts]]
deps = ["FillArrays", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "4aff5fa660eb95c2e0deb6bcdabe4d9a96bc4667"
uuid = "4c555306-a7a7-4459-81d9-ec55ddd5c99a"
version = "0.8.18"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AutoHashEquals]]
git-tree-sha1 = "45bb6705d93be619b81451bb2006b7ee5d4e4453"
uuid = "15f4f7f2-30c1-5605-9d31-71845cf9641f"
version = "0.2.0"

[[deps.BSON]]
git-tree-sha1 = "2208958832d6e1b59e49f53697483a84ca8d664e"
uuid = "fbb218c0-5317-5bc6-957e-2ee96dd4b1f0"
version = "0.3.7"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BlockArrays]]
deps = ["ArrayLayouts", "FillArrays", "LinearAlgebra"]
git-tree-sha1 = "3b15c61bcece7c426ea641d143c808ace3661973"
uuid = "8e7c35d0-a365-5155-bbbb-fb81a777f24e"
version = "0.16.25"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "e30f2f4e20f7f186dc36529910beaedc60cfa644"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.16.0"

[[deps.ChangesOfVariables]]
deps = ["InverseFunctions", "LinearAlgebra", "Test"]
git-tree-sha1 = "2fba81a302a7be671aefe194f0525ef231104e7f"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.8"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "02aa26a4cf76381be7f66e020a3eddeb27b0a092"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.2"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "5ce999a19f4ca23ea484e92a1774a61b8ca4cf8e"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.8.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.1+0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "fe2838a593b5f776e1597e086dcd47560d94e816"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.3"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "cf25ccb972fec4e4817764d01c82386ae94f77b4"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.14"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "b6def76ffad15143924a2199f72a5cd883a2e8a9"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.9"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "b4fbdd20c889804969571cc589900803edda16b7"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.7.1"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FastGaussQuadrature]]
deps = ["LinearAlgebra", "SpecialFunctions", "StaticArrays"]
git-tree-sha1 = "58d83dd5a78a36205bdfddb82b1bb67682e64487"
uuid = "442a2c76-b920-505d-bb47-c5924d526838"
version = "0.4.9"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "299dc33549f68299137e51e6d49a13b5b1da9673"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.1"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "7072f1e3e5a8be51d525d64f63d3ec1287ff2790"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.11"

[[deps.FiniteDiff]]
deps = ["ArrayInterface", "LinearAlgebra", "Requires", "Setfield", "SparseArrays", "StaticArrays"]
git-tree-sha1 = "c6e4a1fbe73b31a3dea94b1da449503b8830c306"
uuid = "6a86dc24-6348-571c-b903-95158fe2bd41"
version = "2.21.1"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions", "StaticArrays"]
git-tree-sha1 = "00e252f4d706b3d55a8863432e742bf5717b498d"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.35"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.Gridap]]
deps = ["AbstractTrees", "BSON", "BlockArrays", "Combinatorics", "DataStructures", "DocStringExtensions", "FastGaussQuadrature", "FileIO", "FillArrays", "ForwardDiff", "JLD2", "JSON", "LineSearches", "LinearAlgebra", "NLsolve", "NearestNeighbors", "PolynomialBases", "QuadGK", "Random", "SparseArrays", "SparseMatricesCSR", "StaticArrays", "Test", "WriteVTK"]
git-tree-sha1 = "31eb81cdfba7c5d1e00e70891b3257719a6237b4"
uuid = "56d4f2e9-7ea1-5844-9cf6-b9c51ca7ce8e"
version = "0.17.17"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0cb9352ef2e01574eeebdb102948a58740dcaf83"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2023.1.0+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "eabe3125edba5c9c10b60a160b1779a000dc8b29"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.11"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLD2]]
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "Pkg", "Printf", "Reexport", "Requires", "TranscodingStreams", "UUIDs"]
git-tree-sha1 = "aa6ffef1fd85657f4999030c52eaeec22a279738"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.4.33"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.LightXML]]
deps = ["Libdl", "XML2_jll"]
git-tree-sha1 = "e129d9391168c677cd4800f5c0abb1ed8cb3794f"
uuid = "9c8b4983-aa76-5018-a973-4c85ecc9e179"
version = "0.9.0"

[[deps.LineSearches]]
deps = ["LinearAlgebra", "NLSolversBase", "NaNMath", "Parameters", "Printf"]
git-tree-sha1 = "7bbea35cec17305fc70a0e5b4641477dc0789d9d"
uuid = "d3d80556-e9d4-5f37-9878-2ab0fcc64255"
version = "7.2.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "c3ce8e7420b3a6e071e0fe4745f5d4300e37b13f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.24"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "154d7aaa82d24db6d8f7e4ffcfe596f40bff214b"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2023.1.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NLSolversBase]]
deps = ["DiffResults", "Distributed", "FiniteDiff", "ForwardDiff"]
git-tree-sha1 = "a0b464d183da839699f4c79e7606d9d186ec172c"
uuid = "d41bc354-129a-5804-8e4c-c37616107c6c"
version = "7.8.3"

[[deps.NLsolve]]
deps = ["Distances", "LineSearches", "LinearAlgebra", "NLSolversBase", "Printf", "Reexport"]
git-tree-sha1 = "019f12e9a1a7880459d0173c182e6a99365d7ac1"
uuid = "2774e3e8-f4cf-5e23-947b-6d7e65073b56"
version = "4.5.1"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "2c3726ceb3388917602169bed973dbc97f1b51a8"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.13"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "2e73fe17cac3c62ad1aebe70d44c963c3cfdc3e3"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.2"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "716e24b21538abc91f6205fd1d8363f39b442851"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.7.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PolynomialBases]]
deps = ["ArgCheck", "AutoHashEquals", "FFTW", "FastGaussQuadrature", "LinearAlgebra", "Requires", "SimpleUnPack", "SpecialFunctions"]
git-tree-sha1 = "b6a02c79b22a5642eed205318da472ca57f4a7de"
uuid = "c74db56a-226d-5e98-8bb0-a6049094aeea"
version = "0.4.18"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "9673d39decc5feece56ef3940e5dafba15ba0f81"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.1.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "6ec7ac8412e83d57e313393220879ede1740f9ee"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.8.2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

[[deps.SimpleUnPack]]
git-tree-sha1 = "58e6353e72cde29b90a69527e56df1b5c3d8c437"
uuid = "ce78b400-467f-4804-87d8-8f486da07d0a"
version = "1.1.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SparseMatricesCSR]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "38677ca58e80b5cad2382e5a1848f93b054ad28d"
uuid = "a0a7dd2c-ebf4-11e9-1f05-cf50bc540ca1"
version = "0.6.7"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "7beb031cf8145577fbccacd94b8a8f4ce78428d3"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.3.0"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "9cabadf6e7cd2349b6cf49f1915ad2028d65e881"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.6.2"

[[deps.StaticArraysCore]]
git-tree-sha1 = "36b3d696ce6366023a0ea192b4cd442268995a0d"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.2"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "45a7769a04a3cf80da1c1c7c60caf932e6f4c9f7"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.6.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "9a6ae7ed916312b41236fcef7e0af564ef934769"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.13"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.VTKBase]]
git-tree-sha1 = "c2d0db3ef09f1942d08ea455a9e252594be5f3b6"
uuid = "4004b06d-e244-455f-a6ce-a5f9919cc534"
version = "1.0.1"

[[deps.WriteVTK]]
deps = ["Base64", "CodecZlib", "FillArrays", "LightXML", "TranscodingStreams", "VTKBase"]
git-tree-sha1 = "7b46936613e41cfe1c6a5897d243ddcab8feabec"
uuid = "64499a7a-5c06-52f2-abe2-ccb03c286192"
version = "1.18.0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "93c41695bc1c08c46c5899f4fe06d6ead504bb73"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.3+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╟─8e25ccb7-7b49-4e9d-90e5-ad4de5473465
# ╟─04aeddda-2ff7-11ee-3a5e-8bb3ef0ba8df
# ╠═35d934a8-5ed4-4578-a2ba-d2fbd494ba7e
# ╟─93df5d91-a432-402d-b85c-56395fb67750
# ╠═48deba06-8334-47d4-a369-17521d804580
# ╠═0103b36e-dcbb-4774-bf94-9bebff55bf76
# ╠═6547039b-1c87-4ef9-b2ad-2a84a038727c
# ╠═76f68199-b3be-43a6-9ea7-a4b6ff541b68
# ╟─4f6cfa6b-0b0b-49e3-ae5c-fe44653eedd5
# ╟─9695b546-0bc8-4473-85e0-afb01dc8e60f
# ╟─5e1c18ef-cd95-4edc-81a6-bf38ec7162c3
# ╠═84dbb3b4-8bec-4b45-b4b3-935e5853dabb
# ╟─0282ab96-9f79-4bbc-a817-b28c46f064dd
# ╟─8f27cc1e-6f03-4f05-b18c-26f61b14629f
# ╠═2c2e3204-7d75-4dc7-9f48-368455b8a200
# ╠═b5457c56-ff7f-4aa3-9427-8bfbdf4e06ff
# ╠═0e2154f2-3982-4efb-8e7c-e6666316cd92
# ╠═8367bf4c-90b5-4a94-82df-72b557f0129e
# ╠═8e93d3d1-015b-429c-92d6-ce397eecf24d
# ╠═264f3c25-5e23-44bd-8354-37cd8d82bf0f
# ╟─aab16cc1-830f-4e74-ba9e-f07e78d27001
# ╟─05779915-ed1d-4c7e-9058-b645e1d331ba
# ╠═5febcf2a-0ca4-40b4-b662-8628b91247f2
# ╟─72be3410-0152-42b1-8f76-bfc3566ea3a3
# ╠═634967ec-5ef2-452b-bef0-72bac47cbb3c
# ╠═50b06284-59bd-45f5-ab34-cfe03e1f91eb
# ╠═13127cbf-857c-4a9b-8df8-bade87cb471d
# ╟─3ba80192-2368-4e95-b670-fcfac76f58de
# ╠═d6b1a809-9a7e-459f-a032-02b982d941a9
# ╠═b74cb151-adcf-46b3-a635-ae965f9a72cd
# ╠═612baddc-f4b8-4599-8f8e-4bcc22205b04
# ╟─b4eefcb0-9303-4885-b2e1-811573dd184c
# ╠═2607d711-f312-4574-bd3c-8ae3f43e8431
# ╠═60eaabfd-716c-44f9-8a5d-2336f7f9a931
# ╠═70eab5c5-9640-4e07-8de2-e0b875298fad
# ╠═669f6613-bd63-4b3d-b3ee-eaf6c67409af
# ╠═3fd17a38-cfeb-464a-be2b-8d11f64230b9
# ╠═d7f3774b-2a96-49b4-b0e3-1d8ee564ac2e
# ╠═3c1c797f-a436-4144-9134-a76b92459cda
# ╠═4d94451f-b697-4d03-9ab9-98445f42b9e0
# ╠═cbec6d57-8e3c-41bd-9bff-0bd871facd50
# ╠═bf04e4e0-b6a2-4a20-b164-937d9e0b9577
# ╠═1eb31813-c3a6-4d3b-a299-0372ce5057a9
# ╠═08d241f3-bff1-4aa7-bd0a-bf7721731ecf
# ╠═1e239a27-d73d-4327-ad34-cd0d3f4aeb1f
# ╟─40bb892b-249c-4285-8845-3ae5248b80da
# ╠═8c8e8d3e-5416-4a8a-811b-6c9042ad9f77
# ╠═3ae90d7b-a168-4bb7-9da0-9f3c3be1db14
# ╠═418b0774-50fd-4afc-89d8-11b3a69eb136
# ╟─1d445c8f-7397-4147-bfdd-96c725d9514c
# ╠═853c10b8-f270-4bf9-9334-5c0fc555562a
# ╟─21440601-8708-4920-a6ca-3e30ca325973
# ╠═8afeef64-3d28-4175-ad84-87ddc6bd6d0c
# ╠═6cb426c1-a002-4c0b-a6be-185999bdc635
# ╠═81d604b5-6424-4e25-9116-5a3507a937a0
# ╟─6956f1c7-ccbd-44ac-9fb1-4c46e8afda49
# ╠═9fcbf35e-a5a7-4a0e-94ee-97697c083575
# ╟─05e10551-e7cc-4b3f-9321-f58162eed217
# ╠═b5362538-64ad-4d60-8e40-aef9c3feb694
# ╠═03b2ad88-cf40-4946-901f-89a8af9b57b4
# ╠═9c212c12-2235-4420-af35-5de876325332
# ╠═53c3011a-9980-434a-960e-8c14fdf81582
# ╠═ff9a97e6-1661-4b56-b3af-9fef26ce6a50
# ╟─76d26b37-6f5a-48cb-b136-a22022bf3c39
# ╟─ef94bd94-21b7-46a0-8a2d-f857b7a064cd
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
