TODO: diff two dataframes
see dataframe-handy.md

>Key concept: if missings are in the DF, you can't `df1 == df2`. 

```julia
propertynames(df)==propertynames(dt)        # true
    # return rows not found in the second dataframe
antijoin(df, dt, on = propertynames(df), validate = (true, true), matchmissing=:equal) |> isempty
antijoin(dt, df, on = propertynames(dt), validate = (true, true), matchmissing=:equal) |> isempty
# programmatically you can check those three with:
    all([expr1, expr2, expr3])
```