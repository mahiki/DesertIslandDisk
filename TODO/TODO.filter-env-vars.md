TODO: small function to filter env

```julia
    # needle can be regex
    # first() gets key, last() gets value
function fenv(needle::Union{AbstractString,AbstractPattern,AbstractChar}; kv="key", dic=ENV)
    if kv == "key"
        f(x) = first(x)
    elseif kv == "value"
        f(x) = last(x)
    else
        @error "Must choose [first | last]" kv dic
    end
    filter(x -> occursin(needle, f(x)), dic)
end
```