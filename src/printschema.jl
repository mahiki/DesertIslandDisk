#==============================================================================
    Generate DataFrame of Column Names and Type from a DataFrame

    package:    DesertIslandDisk
    tested:     
    author:     mahiki@users.noreply.github.com
=============================================================================#

using DataFrames, Dates

"""
    printschema(df::DataFrame)

Return a DataFrame of ordered columns and column type for input dataFrame df

# Examples
```jldoctest
julia> df = DataFrame(a = 1:2, b = [1.0, π], c = [Date("20191002", "yyyymmdd"), Date("21120101", "yyyymmdd")], d = [1//2, missing]);
julia> printschema(df)
4×2 DataFrame
 Row │ variable  value
     │ String    Type
─────┼───────────────────────────────────────────
   1 │ a         Int64
   2 │ b         Float64
   3 │ c         Date
   4 │ d         Union{Missing, Rational{Int64}}
```
"""
function printschema(df::DataFrame)
    dfcols = mapcols(eltype, df)
    dfcolnames = names(dfcols)
    stack(dfcols, dfcolnames)
end


