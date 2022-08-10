# MTH3340

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://monashmath.github.io/MTH3340/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://monashmath.github.io/MTH3340/dev/)
[![Build Status](https://github.com/monashmath/MTH3340/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/monashmath/MTH3340/actions/workflows/CI.yml?query=branch%3Amain)


# Welcome to Unit MTH3340

MTH3340 will introduce you to the numerical approximation of partial differential equations. (PDEs). As you probably know at this stage, the analytical solution of PDEs is only feasible in very limited situations (simple geometries and differential operators).

Many problems of interest in science, engineering, medicine, etc., are modelled by PDEs. However, in practical situations, the analytical solution is not feasible. Therefore, the only way to extract information about these mathematical models is by approximation techniques, the main topic of this unit.

We will see that solutions of PDEs live in infinite dimensional vector spaces (the ones you have learned in linear algebra, but with infinite dimensions). To do this, we will learn about the weak form of a PDE. Then, we will design finite-dimensional spaces that can approximate any function in the infinite-dimensional ones. Finally, by solving our weak form of the PDE in the finite-dimensional space (instead of the infinite-dimensional one), we will get approximations of the exact problem (Galerkin method).

One constructive way to define these approximation spaces is the finite element method. This technique relies upon a geometrical discretisation. The domain in which the PDE is posed is split into "elements", creating a "mesh". By increasing the number of elements, we can approximate the solution with the desired level of accuracy.
Finite element methods transform PDEs into discrete (linear or nonlinear) algebraic systems. Discrete systems can readily be computed using computers. However, the size of these discrete problems increases with the number of elements (more accuracy implies more computational cost). Not surprisingly, the most complex applications (e.g., mantle convection on the Earth's crust or the flow around an aircraft) require supercomputers to be solved accurately.

In this unit, we will go through all these methods, paying particular attention to their mathematical foundations. In any case, we will also learn how to implement these algorithms and use advanced scientific software [`Gridap`](https://github.com/gridap/Gridap.jl) to run these methods and gain intuition. `Gridap` is written in Julia, a pretty recent programming language. Thus, we will use Julia in MTH3340.

# Introduction

Please check [here](https://github.com/MonashMath/MTH3340/blob/main/INTRODUCTION.md)

# Installing `Julia` and running the tutorials

Please check [here](https://github.com/MonashMath/MTH3340/blob/main/TUTORIALS.md)

# Lecture notes for this unit

Find the lecture notes [here](https://github.com/MonashMath/MTH3340/blob/main/assets/mth3340-lecture-notes.pdf)
