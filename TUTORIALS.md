# Computational finite element tutorials

These tutorials are delivered by [@santiagobadia](https://github.com/santiagobadia).

In this set of tutorials, we will use the [`Gridap`](https://github.com/gridap/Gridap.jl) software library developed by [@santiagobadia](https://github.com/santiagobadia) and co-workers. This library provides tools for the numerical approximation of partial differential equations using mesh-based techniques (finite element methods in general). The library is written in [`Julia`](https://julialang.org), a somehow recent programming language that combines the expressiveness of dynamic languages like `Python` and the performance of static languages like `C++` or `FORTRAN`.

It is not the aim of this course to teach `Julia`, and you are not going to be asked to implement very advanced algorithms from scratch. What will be presented can be understood without a thorough primer in `Julia`. It is more about understanding the steps in a finite element software (mesh generation, creation of finite element spaces, bilinear forms, linear system, and solver) and justifying the results obtained using what we have learned from their mathematical analysis.

## Installing `Julia`

For this practical work, you need to install Julia locally on your computer. Installing all the tools that are needed for running these notebooks locally is pretty simple. The first thing that you have to do is to download `Julia` from [here](https://julialang.org/downloads/). Pick the one for your operating system. If you use Windows and a not-too-old computer, download the 64-bit installer. I would recommend you install the newest stable release.

If you install Julia on Windows, you can accept the proposed directory for installation (unless you want to change it for some reason), press _NEXT_, tick **(very important)** `Add Julia Path` in the next window, press _NEXT_. You can tick `Run Julia` if you like in the last window and _FINISH_. You will have now the `Julia` app in Windows, and you can use it to open new `Julia` windows. I think something very similar will work on Mac.

If you install `Julia` in `Linux`, you will need to manually add the folder with the `Julia` executable to the environment variable `PATH` in your `.bashrc`, e.g.:
```
export PATH=$HOME/Progs/julia-1.6.1/bin
```

## Installing VSCode

On the other hand, you need a good editor for Julia. I recommend using VSCode. You can install the latest version for your operating system [here](https://code.visualstudio.com/). Simply click the link for last stable version. 

In Windows, run the executable file you have downloaded. Accept the agreement, press _NEXT_, accept the folder proposed or change it if you want, _NEXT_, _NEXT_, then you can tick `Create a desktop icon` and **keep ticked** `Add to PATH` **(very important)**, _NEXT_, _INSTALL_. After installation, _FINISH_. I think something very similar will work on Mac. If you are on Linux, you don't need help :-)

Now, open VSCode (if not already open) and click on `Extensions` (the icon with four squares on the left side). Now, you can search in `Extension` for `Julia`. The first result will be `Julia Language Support`. We want to install this plug-in. Click on `Install` on this extension.

If everything worked, now you should be able to open a `Julia` REPL (a `Julia` terminal) in VSCode. You can just press `CTRL+SHIFT+P` (to open a search menu) and type `Julia: Start REPL`. Click on the first result. If a Julia REPL opens, you got it!

## Download the tutorials

Now, you can download the .zip with the tutorials [here](https://github.com/MonashMath/MTH4321/archive/refs/heads/master.zip). Every tutorial is related to one chapter of the lecture note. You can find:

* Practical tutorial Chapter 1: In `Tutorials.jl/src/t1-gridap-poisson.jl`

* Practical tutorial Chapter 2: In `Tutorials.jl/src/t2-gridap-convergence-tests.jl`

* Practical tutorial Chapter 3: In `Tutorials.jl/src/t3-low-level-poisson-solver.jl`

* Practical assignment: In `Tutorials.jl/src/assignment.jl`

## Run the tutorials in VSCode

Now, go to `File -> Open Folder` (or just click on the Explorer icon on the left) and open `Tutorials.jl`. Next, open a Julia REPL (as explained above). You have in the bottom of your VSCode windows

```
julia> 
```
This is the _standard_ mode of the `Julia` REPL, in which you can run commands. However, in order to run the tutorials, we need to install some packages and type `] instantiate`. 

Instantiate the environment. This will automatically download all required packages.
```
# Type ] to enter in pkg mode
(Tutorials) pkg> instantiate
```

Note that `]` will change the prompt to package mode (`(Tutorials) pkg>`). To go to normal mode again you just press `backspace` key. It is good to know that you can have the REPL in these two modes. The standard mode `julia>` is the one that you will use all the time to run commands. The package mode is only used for packages related things (e.g., instantiate a project or install new packages). Instantiate will install the Julia packages that are required to run the tutorials (Gridap and its dependencies). It will take some time. If there are no errors, you can start running the tutorial (open the desired tutorial in `src/` folder). You can just go to the `Explore` icon on the top-left and click on the tutorial you want to run.

First, check that you are in standard mode `julia>`, if you are in package mode `(tutorials) pkg>` type backspace. You can run a `Julia` file in many different ways. I would probably start running the whole file to check that everything is OK. As usual, open the VSCode search using `CTRL+SHIFT+P` and search for `Julia execute file in REPL` and choose this option. If everything works, you will see a message with the L2 error of your solution.

For reading the comments (in which I explain what we are doing in the code), I recommend using "soft wrapping of lines". Just press `ALT+Z` or go to `View > Toggle Word Wrap`.

In order to go through the tutorials, I strongly recommend executing line by line from the very beginning. You can do that with `CTRL+ENTER` on a line. Then, you can see the result in the REPL, and try to understand the numbers you are getting. If you click on the `Julia` link on the left (the three circles) you will be able to see the Workspace (as in Matlab) with all the variables and their values.

Now, you can run the whole terminal, and understand what we are doing at every stage. Try to check how the code relates to the lecture notes, and check that we are implementing exactly matches what we explain there.

Let me know if there is any technical problem or doubts in the tutorial. Have fun!

# Creating Jupyter Notebooks

If you want, you can also run the tutorials using Jupyter notebooks. I think it is better to run the code in VSCode. In any case, here you can see how to do that.

Build the notebooks
```
# Type Ctrl+C to get back to command mode
julia> include("deps/build.jl")
```

Open the notebooks
```
julia> using IJulia
julia> notebook(dir=pwd())
```
This will open a browser window. Navigate to the `notebooks` folder and open the tutorial you want. Voila!
