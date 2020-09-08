#==============================================================================
    Convert variable name to string

    package:    DesertIslandDisk
    tested:     PASS
    depend:     NO
    author:     longemen3000@stackoverflow
 =============================================================================#

"""
    @tostring

Return the variable, function, Symbol, object, et al name as a string.

@tostring(arg::Any)

# Examples
```jldoctest
julia> a = 55;
julia> bingo = "I'm the new sherrif";
julia> ch = 'd';
julia> hippy(x) = x^2
julia> var1 = @tostring a
"a"
julia> var2 = @tostring bingo
"bingo"
julia> var3 = @tostring(ch)     # macro as function call
"ch"
julia> var4 = @tostring hippy
"hippy"
# note: function names can be returned with string()
julia> string(hippy)
"hippy"
```
"""
macro tostring(aeg::Any)
    x = string(aeg)
    quote
        $x
    end
end
