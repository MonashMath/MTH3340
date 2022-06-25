using MTH3340
using Documenter

DocMeta.setdocmeta!(MTH3340, :DocTestSetup, :(using MTH3340); recursive=true)

makedocs(;
    modules=[MTH3340],
    authors="Santiago Badia <santiago.badia@monash.edu>",
    repo="https://github.com/santiagobadia/MTH3340.jl/blob/{commit}{path}#{line}",
    sitename="MTH3340.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://santiagobadia.github.io/MTH3340.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/santiagobadia/MTH3340.jl",
    devbranch="main",
)
