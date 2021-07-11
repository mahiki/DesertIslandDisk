#==============================================================================
    Generate DataFrame of Column Names and Type from a DataFrame

    package:    DesertIslandDisk
    tested:     
    author:     mahiki@users.noreply.github.com
 =============================================================================#

using DataFrames

"""
    @tostring

Return a DataFrame of ordered columns and column type for input dataFrame df

@tostring(arg::Any)

# Examples
```jldoctest
julia> df = DataFrame(a = 1:2, b = [1.0, π], c = [Date("20191002", "yyyymmdd"), Date("21120101", "yyyymmdd")], d = [1//2, missing])
julia> printschema(df)
```
"""
function printschema(df::DataFrame)
    dfcols = mapcols(eltype, df)
    dfcolnames = names(dfcols)
    stack(dfcols, dfcolnames)
end


