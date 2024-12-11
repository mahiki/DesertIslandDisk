#=  ================================================================================================
    interval_label

    customized string representation of time intervals, conceived for setting labels on the
    x-axis where the scale is logarithmic, with some rounding for scale.
    Returned string must be compact for display purposes. Example:

        [1, 10, 100, 1000, 10000, 100_000] ->
        ["1s", "10s", "1m 40s", "16m 40s", "2h 46m", "1d 3h"]

    author:     mahiki@users.noreply.github.com
=   ===============================================================================================#

# TODO: Assume no Year/Month time periods input allowed, since uncertain num of days.

using Dates

"""
    interval_label(p::Dates.FixedPeriod)

Return a string of a simplified time-annotated interval. Best used for plot axis tick labels.
The type contraint of FixedPeriod gaurantees successful conversion between Periods, as Year/Month are not constant valued.

# Examples
```jldoctest
julia> testperiod = [Dates.Second(86400), Dates.Day(420), Dates.Second(2303)];
julia> interval_label(testperiod[1])
1d
julia> interval_label(testperiod[2])
1y 55d
julia> interval_label(testperiod[3])
38m 23s
````
"""
function interval_label(p::Dates.FixedPeriod)
    convert(Millisecond, p)
    # TODO: GCD logic to get y/d/h/min/s/frac seconds groups
end