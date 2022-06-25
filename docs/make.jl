using MTH3340
using Documenter

DocMeta.setdocmeta!(MTH3340, :DocTestSetup, :(using MTH3340); recursive=true)

makedocs(;
    modules=[MTH3340],
    authors="Santiago Badia <santiago.badia@monash.edu>",
    repo="https://github.com/monashmath/MTH3340/blob/{commit}{path}#{line}",
    sitename="MTH3340",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://monashmath.github.io/MTH3340",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/monashmath/MTH3340",
    devbranch="main",
)
