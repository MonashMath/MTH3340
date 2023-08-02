using Markdown
using InteractiveUtils

using LinearAlgebra

using Plots

md"# Basic Julia syntax

In this tutorial, we will learn the basic syntax of `Julia`. This part is not as deep as the previous part. If you know Python, you will see that the differences are not that important.
"

md"## Logical operations

`Bool` type has two possible different values, `true` and `false`. `Bool` is a sub-type of `Number`, since `true` can be considered to be 1 ` and `false` 0.

If `x` and `y` are `Bool`, we can also express (not `x`) as `!x`, (`x` and `y`) as
`x && y`., and (`x` or `y`) as `x || y`."

a = 10

x = (a > 7)

!x

y = (a > 2) && (a < 8)

z = (a > 2) || (a < 8)

q = a > 5 ?  10 : a + "hello" # short-circuited


md"## For loops

The most basic syntax for a `for` loop is the following.

"

begin
	c = 0
	for k in 1:100 # or k = 1:100 or k ∈ 1:100
		c = c + k
	end
end

c == 100*101/2

begin
   d = 0
   for i in 1:100
	   for j in 1:100
	   d = i + j
	   end
   end
end

begin
   e = 0
   for i in 1:100, j in 1:100
	   e = i + j
   end
end

d == e

begin
	f = 0
	for i ∈ 1:10000
		α = 1/2^i
		if α < 10^-8
			f = i
			break
		end
	end
end

f

md"## Functions

As discussed before, functions are an essential part of `Julia`. It is also very important to use functions to allow the JIT compiler to compile these functions.

Let us consider Leibniz formula for π.

π/4 = 1 - 1/3 + 1/5 - 1/7 + 1/9...
"

β(m) = m == 1 ? 0 : 1

function Leibniz_formula(n) # n is number of terms
	c = 0; s = 0
	for i in 0:n
		j = 2*i+1
		s = s + 1/j*(-1)^c
		c = β(c)
	end
	return 4s # or just 4s
end

Leibniz_formula(1)

function Leibniz_formula_with_error(n)
	π_ap = Leibniz_formula(n)
	π_ap, π - π_ap
end

Leibniz_formula_with_error(100000)

md"In general, functions should not modify the input values. That is not mathematically sound! In fact, in _pure_ functional analysis (e.g., Haskell), all functions are _pure_. However, this level of idealism clashes with pragmatism (as usual). `Julia` is quite pragmatic, and allows one to define non-pure functions.

This is very important in e.g. numerical linear algebra. Let us assume that we want to create a function that adds a value in one entry of a huge vector. It is very impractical (expensive) to create a new array. Instead, if it is possible in the code, it is much faster just to _mutate_ the input array.

Functions that mutate their input are indicated in `Julia` with `!` (notation)."

begin # multiple def'on creates problems in Pluto, better use the REPL
	mv = [1,2,3]
	function add_one_in_j!(y,j)
		y[j] = y[j]+1
		y
	end
	add_one_in_j!(mv,1)
	print(mv) # mv = [2,2,3]
end

md"Our functions can be *anonymous* (no need to assign a name). This is an essential feature in functional programming. You can use functions as any data type, they are first class citizens.

Let us implement the bisection method. The function we want to find its root is passed as an argument.
"

function bisection(f, a, b, tol=1e-6, max_iter=100)
    if f(a) * f(b) > 0
        throw(ArgumentError("Function must have opposite signs at endpoints."))
    end

    for i in 1:max_iter
        c = (a + b) / 2
        if abs(f(c)) < tol
            return c
        elseif f(a) * f(c) < 0
            b = c
        else
            a = c
        end
    end

    throw(ArgumentError("Bisection method did not converge within the maximum number of iterations."))
end

md"Now we call this function, using an anonymous function."

bisection(x -> 3x^2-2,0,2) # x -

md"## Arrays, vectors and matrices


"

md"## Arrays

As we already know, `Julia` provides native support for multidimensional arrays, and in particular, vectors and matrices. The language already provides lots of linear algebra types and methods.

However, we do not need to transform everything to array operations for being efficient (also called vectorisation). This is needed in Python, because Python code is very slow (not compiled but interpreted in run-time). Vectorising, we can implement the operations in other language (e.g. C, like numpy). This is the way to be efficient in Python, by moving to other language.

On the contrary, `Julia` code can be super-fast. You can create for loops that are fast, so no need to vectorise or to move to other languages.
"

A = [1 2 3; 4 5 6; 7 8 9] # an array constructor

B = [1.0, 2.0, 3.0] # a vector constructor, also with ;

typeof(B)

C = ["a" "b" "c"] # a row vector (1x3 matrix)

D = [1 2.3 4.5 5] # automatically using conversion in a clever way

E = ["Hello" 1 2.0 3]

md"The most concrete type common ancestor is `Any`! Not much

As a rule of thumb, you want a very concrete type in an array. This way, the compiler can do an excellent job. E.g., it does not need to check the type of entries it has every time, and based on that, decide (via multiple dispatching) which is the best method, etc. On the contrary, if the compiler knows that the array only contains `Float64`, it can generate much faster machine code. This is call _type stability_. A good `Julia` programmer will decide what to type to enforce this. If you don't type anything, your code will be type unstable. (Again, not a big deal in this unit.)
"

md"### Array comprehension

You can define arrays in a very concise way as follows"

v = [1/n^2 for n in 1:10]

md"### Array initialisation

You can also initialise an array and then change (assign) its entries. You can assign to `undef` (undefined value).
"

begin
	K = Array{Float64}(undef,5) # or Matrix{Float64}
end

begin
	b = Array{Float64}(undef,5) # or Vector{Float64}
end

md"You can also create empty arrays and then push new entries with `push!`"

b2 = Float64[]; push!(b2,1.0)
# you can do b2 = [] but then it will be an array of `Any`

md"You can also initialise matrices and vectors with 0 and 1."

K2 = zeros(4,4)

b3 = ones(5)

md"Finally, you can use many other methods from `LinearAlgebra`. It has e.g. an identity matrix I."

K3 = 2I + K2

md"You can apply function entry-wise with the dot notation"

K4 = sin.(K3)

md"# Plots

There are different packages for plotting. For our needs, we can just use `Plots`. The syntax is very similar to what you can find in Python. In fact, it can internally use `Matplotlib`. The best way to learn how to use this package is to take a look at the [documentation](https://docs.juliaplots.org/latest/).
"

xv = 0:0.01:1

yv = sin.(2π*xv) + 0.1*sin.(16π*xv)

plot(xv,yv)
