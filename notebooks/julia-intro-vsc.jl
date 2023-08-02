using Markdown
using InteractiveUtils

using Gridap

a = 5+3

typeof(a)

b = "Hello"

typeof(b)

# Run these lines in a Julia REPL
using AbstractTrees
AbstractTrees.children(d::DataType) = subtypes(d)
print_tree(Number)

Float64(5)

Int64(3.0)

Int64(7.6) # 7.6 cannot be converted to Int64 without changing its value

floor(Int64,7.6)

ceil(Int64,7.6)

Float64("hello")

f(x) = x^2

f(2)

f(1.5)

f([1 0; 0 2])

nice_sum(a::Real,b::Real) = "The sum of these two Float64 numbers is $(a+b)"

nice_sum(1.0,2.0) # We have not implemented this! Why does it work? (see the Real tree)

nice_sum(3,4) # We have not implemented this! Why does it work? (see the Real tree)

nice_product(a::Float64,b::Float64) = "The product of these two Float64 is $(a*b)"

nice_product(1.0,3.0) # Default is Float64

nice_product(1,3) # Why this is not working? (check the Real tree again)

nice_division(a::Int,b::Int) = "The quotient of these two Integer numbers is $(a/b)"

nice_division(a::Real,b::Real) = "The quotient of these two Real numbers is $(a/b)"

nice_division(a::Int,b::Real) = "The quotient of these Integer and Real numbers is $(a/b)"

nice_division(a::Real,b::Int) = "The quotient of these Real and Integer numbers is $(a/b)"

nice_division(1,3)

nice_division(0.5,6.7)

nice_division(3,4.5)

nice_division(4.5,3)

struct ExponentialDiagonalVector1
	r
	d::Int
end

A = ExponentialDiagonalVector1(3.0,2)

typeof(A)

struct ExponentialDiagonalVector2{T<:Number}
	r::T
	d::Int
end

begin
# begin end are only needed for Pluto (to include more than one instruction in a cell)
  B = ExponentialDiagonalVector2(4.0,5)
  C = ExponentialDiagonalVector2(6,5)
end

typeof(B)

typeof(C)

struct ExponentialDiagonalVector3{T} <: AbstractVector{T} # or AbstractArray{T,1}
	r::T
	d::Int
end

begin
    Base.size(A::ExponentialDiagonalVector3) = (A.d,A.d)
	Base.IndexStyle(::Type{ExponentialDiagonalVector3}) = IndexLinear()
	Base.getindex(A::ExponentialDiagonalVector3,i::Int) = A.r^i
end

md"# Introduction to Julia

In this tutorial, we will learn the basics of `Julia`. We can run this tutorial from VSCode, using the REPL, or as a Pluto notebook.
"

md"## Installing packages

The `Julia` package manager is simply great. You can easily install `Julia` packages included in the `Julia` registry from the REPL. Below, we are importing and installing `Gridap`, the finite element code we are going to use in some of the lectures.
"

md"## Basic variables

`Julia` is the choice for this unit for a very simple reason. It is easy to use and can be very fast. The typical motto is _walks like Python, runs like C_. It means that you can easily prototype codes like in an *interpreted language* (like Python). There is no need to type each and every variable you aim to use in a header, as one does in *compiled* languages like C, C++ or FORTRAN. We call this way of coding _duck typing_. As soon as the code _makes sense_ (e.g., you cannot compute the absolute value of a string), you don't need to explicitly provide the type of your variables.
"

md"We did not explictly assign a type to these variables, the language did it for us."

md"## The type ecosystem"

md"One of the most important parts to understand when we start working with `Julia` is the *type ecosystem*. We can think of it as a huge tree, the root being the most abstract type and getting more concrete as we go up through the branches. This is called the type hierarchy. For instance, we can see below the portion of the type ecosystem that starts in `Number` (great example for a math unit)."

md"It makes mathematical sense, a rational number is a sub-type of a real number, which is a sub-type of a number."

md"The type system provides conversions between types (if possible). E.g., we can convert integers to floats. However, we cannot convert a float to an integer (in general)."

md" The type ecosystem is dynamic, i.e., you can extend it adding your sub-types. The root of the type system is `Any`. You can see the huge Julia type system by plotting the type tree of `Any`."

md"## Multiple dispatching

`Julia` is *not* based on the object-oriented programming language (unlike Python, or C++). If you are expert in OOP, you need to adapt to a new way of thinking. Leaving computer science technicalities aside, the core of `Julia` programming paradigm is *multiple dispatching*. Multiple dispatch provides a mechanism to define a function with different implementations, and to pick the implementation depending on the type of multiple arguments. It is strongly connected to the dynamic type system.

`Julia` also uses many features of `functional` programming. We can declare functions, pass them as arguments of other functions, etc.

Let us create our first function.
"

md"We can now apply this function to any existing `Julia` existing type for which its square makes sense (and it has been implemented). So, we can apply `f` to any kind of number, matrix, etc."

md" Internally, Julia is using multiple dispatching to decide whether to use the product of numbers or matrices (totally different implementations). Let us create our own multiple dispatching example.

First, we create a function that adds two Float64 numbers and writes a message"

md"Let us create another example. We create now `nice_product` for Integer"

md"Now let us define another method for division, now using (simple) dispatching"

md"And now examples of multiple dispatching."

md"## Data types

In `Julia`, you can define your own data types and extend the type system. In particular, you can define composite types (`struct`). Combining this dynamic type system with multiple dispatching provides a very extensible and powerful language.

In `Julia`, all `array` types are sub-types of an abstract type called `AbstractArray`. Let us create a very specific array. Let us consider a vector such that, given a number `r` and a length `D`, has diagonal values `r^1, r^2, ..., r^(D-1)`. We will call this vector type `ExponentialDiagonalVector`. We will create more than one type to learn different important aspects of `struct`. We will call them `ExponentialDiagonalVector1`, `ExponentialDiagonalVector2`,...
"

md"We can do better. We can use template parameters. I.e., we can define in one shot so many different types. E.g., a vector can be a vector of reals, integers, etc. With the constructor above, the type `ExponentialDiagonalVector1` does not provide any information about the kind of numbers it stores."

md"Here, `T` is the template parameter and `T<:Number` means that `T` must be a sub-type of `Number`. We don't want to create matrices with e.g. strings. Now, let us see what info we get after creating our vector."

md"The type `ExponentialDiagonalVector2{Float64}` tells us that the vector has  `Float64` entries. This type is different from, e.g. `ExponentialDiagonalVector2{Int64}`. So you can define different implementations (e.g., the dot product) for each case and dynamically pick the right implementation using multiple dispatching. Probably, it does not make much sense in this example, but it does in more complex situations.

You can have as many template parameters as you want.

For instance `AbstractArray{T,D}` type in `Julia` has two template parameters, `T` is the type of the array entries and `D` is the dimension of the array (e.g., 1 for vectors and 2 for matrices). An `AbstractVector{T}` is an alias for `AbstractArray{T,1}`.

The possibility of extending existing types in the type system is one of the most powerful features of 'Julia'. It is clear that `ExponentialDiagonalVector2{Float64}` should be a subtype of `AbstractArray{Float64,1}`. We can do that as follows.
"




md"And now the magic comes. Which are the most basic methods that an array should be able to answer? In other words, which is the _interface_ of `AbstractArray` in `Julia`?

You can find it here: [https://docs.julialang.org/en/v1/manual/interfaces/](https://docs.julialang.org/en/v1/manual/interfaces/)

To understand the interface is too much at this stage. Let us consider the _required_ methods.
"

D = ExponentialDiagonalVector3(4.0,3)

getindex(D,5)

size(D)

dot(D,D)

md"Who implemented the dot product of vectors? The inner product of functions can be implemented for an abstract array just using `size` and `getindex`. In `Julia`, there is an implementation of the dot product for this abstract type. We have created a sub-type of `AbstractVector`. Using multiple dispatch, `Julia` seeks the most _concrete_ `dot` implementation. In this case, since we have not implemented one for `ExponentialDiagonalVector3`, it uses the one for `AbstractVector` in `Julia`.

 Note that `ExponentialDiagonalVector2` is not a sub-type of `AbstractVector`, so we are not able to re-use `Julia` generic code.

You probably see now the potential of this language."

md"## Just-in-time compilation

Why is `Julia` much faster than `Python`, and as fast as typed (compiled) languages like C?

You have seen that in `Julia` you can write code like in `Python`, without declaring the type of your variables (type annotation). But *you can also annotate the type* if you want. Why would you do this extra work?

The reason is that `Julia` compiles code on the fly, e.g., in run-time. If you declare the type of a function argument, the compiler can do many optimisations (as in C, FORTRAN,...) and end up with very efficient code.

In `Julia`, you can quickly write a prototypical code (not paying attention to performance, without typing) or write extremely fast code (using type annotation in the right places). To know when you should provide the type is not easy, and requires some understanding on how `Julia` and its JIT compiler work.

In any case, performance is not an issue in this unit."
