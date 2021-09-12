#==============================================================================
    Transpose 5 rows of DataFrame for easy viewing

    TODO:       kwarg to randomly select rows

    author:     mahiki@users.noreply.github.com
=============================================================================#

using DataFrames, Dates

"""
    df_transpose(df::DataFrame; n=5)

Take the first n rows of dataframe and transpose to read columns sideways, useful for viewing wide dataframes

# Examples
```jldoctest
julia> df = DataFrame(a = 1:2, b = [1.0, π], c = [Date("20191002", "yyyymmdd"), Date("21120101", "yyyymmdd")], d = [1//2, missing]);
julia> df_transpose(df)
4×3 DataFrame
 Row │ variable  1           2
     │ String    Any         Any
─────┼──────────────────────────────────
   1 │ a         1           2
   2 │ b         1.0         3.14159
   3 │ c         2019-10-02  2112-01-01
   4 │ d         1//2        missing
```
"""
function df_transpose(df::DataFrame; n=5)
    dfn = df[1:n,:]
    colnames = names(dfn)
    dfn[!, :id] = 1:size(dfn, 1)
    dfi = stack(dfn, colnames)
    unstack(dfi, :variable, :id, :value)
end
