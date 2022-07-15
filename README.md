# MTH3340

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://monashmath.github.io/MTH3340/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://monashmath.github.io/MTH3340/dev/)
[![Build Status](https://github.com/monashmath/MTH3340/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/monashmath/MTH3340/actions/workflows/CI.yml?query=branch%3Amain)


# Welcome to Unit MTH3340

MTH3340 will introduce you to the numerical approximation of partial differential equations. (PDEs). As you probably know at this stage, the analytical solution of PDEs is only feasible in very limited situations (simple geometries and differential operators).

Many problems of interest in science, engineering, medicine, etc, are modeled by PDEs. In practical problems, the analytical solution is not feasible. The only way to extract information about these mathematical models is by approximation techniques, the main topic of this unit.

We will see that solutions of PDEs live in infinite dimensional vector spaces (the ones you have learned in linear algebra, but with infinite dimensions). To do this, we will learn about the weak form of a PDE. Then, we will design finite-dimensional spaces that can approximate any function in the infinite dimensional ones. Solving our weak form of the PDE in the finite-dimensional space (instead of the infinite dimensional one), we will get approximations of the exact problem (Galerkin method).

One constructive way to define these approximation spaces is the finite element method. This technique relies in a geometrical discretisation of the domain in which our PDE is posed. This domain is split into "elements", creating a "mesh". Increasing the number of elements, we can approximate as well as desired the original space and the approximation to the solution.

Finite element methods transform PDEs into discrete (linear or nonlinear) algebraic spaces. Discrete spaces can readily be computed using computers. The size of these discrete problems increases with the number of elements (more accuracy implies more computational cost). Thus, it is not surprising that the most complex problems (e.g., mantle convection on the Earth's crust or the flow around an aircraft) require supercomputers for being accurately solved.

In this unit, we will go through all these methods, paying special attention to the mathematical foundations of these numerical methods. In any case, we will also learn how to implement these algorithms and use advanced scientific software [`Gridap`](https://github.com/gridap/Gridap.jl) to run these methods and gain intuition about them. `Gridap` is written in Julia, a quite recent programming language. Thus, we will use Julia in MTH3340.

