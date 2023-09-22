"""
    miss_nan(df::DataFrame)
Replace dataframe elements that are `NaN` or `Inf` with `missing`. This facilitates writing DataFrames to CSV for use in reports, where `missing` is nicely interpreted as an empty cell.
"""
function miss_nan(df::AbstractDataFrame)
    for col in eachcol(df)
        replace!(col, NaN => missing)
        replace!(col, Inf => missing)
    end
end
