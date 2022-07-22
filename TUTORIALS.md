# Computational finite element tutorials

In this set of tutorials, we will use the [`Gridap`](https://github.com/gridap/Gridap.jl) software library developed by [@santiagobadia](https://github.com/santiagobadia) and co-workers. This library provides tools for the numerical approximation of partial differential equations using mesh-based techniques (finite element methods in general). The library is written in [`Julia`](https://julialang.org), a somehow recent programming language that combines the expressiveness of dynamic languages like `Python` and the performance of static languages like `C++` or `FORTRAN`.

The tutorials are mainly about understanding the steps in a finite element software (mesh generation, creation of finite element spaces, bilinear forms, linear system, and solver) and justifying the results obtained using what we have learned from their mathematical analysis. The `Julia` requirements for this unit are quite low and can be understood with the guidance and examples in the tutorials. 

## Installing `Julia`

For this practical work, you need to install Julia locally on your computer. Installing all the tools that are needed for running these notebooks locally is pretty simple. The first thing that you have to do is to download `Julia` from [here](https://julialang.org/downloads/). Pick the one for your operating system. If you use Windows and a not-too-old computer, download the 64-bit installer. I would recommend you install the newest stable release.

If you install Julia on Windows, you can accept the proposed directory for installation (unless you want to change it for some reason), press _NEXT_, tick **(very important)** `Add Julia Path` in the next window, press _NEXT_. You can tick `Run Julia` if you like in the last window and _FINISH_. You will have now the `Julia` app in Windows, and you can use it to open new `Julia` windows. I think something very similar will work on Mac.

If you install `Julia` in `Linux`, you will need to manually add the folder with the `Julia` executable to the environment variable `PATH` in your `.bashrc`, e.g. (for version 1.6.1):
```
export PATH=$HOME/Progs/julia-1.6.1/bin
```

## Installing VSCode

On the other hand, you need a good editor for Julia. I recommend using VSCode. You can install the latest version for your operating system [here](https://code.visualstudio.com/). Simply click the link for last stable version. 

In Windows, run the executable file you have downloaded. Accept the agreement, press _NEXT_, accept the folder proposed or change it if you want, _NEXT_, _NEXT_, then you can tick `Create a desktop icon` and **keep ticked** `Add to PATH` **(very important)**, _NEXT_, _INSTALL_. After installation, _FINISH_. I think something very similar will work on Mac. If you are on Linux, you don't need help :-)

Now, open VSCode (if not already open) and click on `Extensions` (the icon with four squares on the left side). Now, you can search in `Extension` for `Julia`. The first result will be `Julia Language Support`. We want to install this plug-in. Click on `Install` on this extension.

If everything worked, now you should be able to open a `Julia` REPL (a `Julia` terminal) in VSCode. You can just press `CTRL+SHIFT+P` (to open a search menu) and type `Julia: Start REPL`. Click on the first result. If a Julia REPL opens, you got it!

## Download the tutorials

Every tutorial is related to one chapter of the lecture note. You will find the tutorials below (during the semester):

* Practical tutorial Chapter 1: [https://github.com/MonashMath/MTH3340/blob/main/notebooks/tutorial-1.jl](https://github.com/MonashMath/MTH3340/blob/main/notebooks/tutorial-1.jl)

# Run the tutorials using `Pluto`

The tutorials are `Pluto` notebooks (a more advanced version of Jupyter notebooks for Julia). Please, follow the installation instructions [here](https://github.com/fonsp/Pluto.jl#installation). You can simply download the notebook and open it in the browser, after running `Pluto`. This will open a browser window. Navigate to the `notebooks` folder and open the tutorial you want. Voila!

## Run the tutorials in VSCode

Now, go to `File -> Open Folder` (or just click on the Explorer icon on the left) and open `MTH3340`. Next, open a Julia REPL (as explained above). You have in the bottom of your VSCode windows

```
julia> 
```
This is the _standard_ mode of the `Julia` REPL, in which you can run commands. However, in order to run the tutorials, we need to install some packages and type `] instantiate`. 

Instantiate the environment. This will automatically download all required packages.
```
# Type ] to enter in pkg mode
(MTH3340) pkg> instantiate
```

Note that `]` will change the prompt to package mode (`(Tutorials) pkg>`). To go to normal mode again you just press `backspace` key. It is good to know that you can have the REPL in these two modes. The standard mode `julia>` is the one that you will use all the time to run commands. The package mode is only used for packages related things (e.g., instantiate a project or install new packages). Instantiate will install the Julia packages that are required to run the tutorials (Gridap and its dependencies). It will take some time. If there are no errors, you can start running the tutorial (open the desired tutorial in `src/` folder). You can just go to the `Explore` icon on the top-left and click on the tutorial you want to run.

First, check that you are in standard mode `julia>`, if you are in package mode `(MTH3340) pkg>` type backspace. You can run a `Julia` file in many different ways. I would probably start running the whole file to check that everything is OK. As usual, open the VSCode search using `CTRL+SHIFT+P` and search for `Julia execute file in REPL` and choose this option.

For reading the comments (in which I explain what we are doing in the code), I recommend using "soft wrapping of lines". Just press `ALT+Z` or go to `View > Toggle Word Wrap`.

In order to go through code files, I strongly recommend executing line by line from the very beginning. You can do that with `CTRL+ENTER` on a line. Then, you can see the result in the REPL, and try to understand the numbers you are getting. If you click on the `Julia` link on the left (the three circles) you will be able to see the Workspace (as in Matlab) with all the variables and their values.

Now, you can run the whole code and understand what we are doing at every stage. Try to check how the code relates to the lecture notes, and check that we are implementing exactly matches what we explain there.

Let me know if there is any technical problem or doubts in the tutorial. Have fun!
