#=  ================================================================================================
    CLI Calculation Functions
    little things to make testing/debugging data pipelines easier

    author:     mahiki@users.noreply.github.com
=   ===============================================================================================#


"""
    addcb(x::AbstractString)

Add Clipboard. Parse the clipboard contents as a series of numbers, add them and return the sum.
Example usage is copying a column of numbers from terminal and adding them.

# Examples
```jldoctest
julia> clipboard("55 76 \n13, 22")
julia> addcp()
166
```
"""
function addcb()
    dlmregex = r"[\s,;|]"
    x = clipboard()
    m = split(x, dlmregex, keepempty = false)
    total = sum(tryparse.(Float64, m))
    return total
end