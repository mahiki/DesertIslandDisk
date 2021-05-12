#==============================================================================
    stuff to look up from the reply
    usage uncertain so far

    TODO:   this needs to parse keyword tokens and search the array elements

    package:    DesertIslandDisk
    tested:     eh
    depend:     NO
    author:     mahiki@
 =============================================================================#

"""
    @remindme

Return helpful text based on keywords.

@remindme(keyword)

# Examples
```jldoctest
julia> @remindme perf;
avoid non-constant globals
focus on inplace operations
write for-loops
minimize type-instabilities
```
"""
macro remindme(keyword)
    x = string(keyword)

    for patt in keys(remindmelist)
        if occursin(x, patt)
            for item in remindmelist[patt]
                println(item)
            end
        end
    end
end

# need to match key and call those keys


remindmelist = Dict(
    "performance tips" =>
        [
            "avoid non-constant globals"
            "focus on inplace operations"
            "write for-loops"
            "minimize type-instabilities"
        ]
    )
