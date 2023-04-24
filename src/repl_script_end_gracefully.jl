#==============================================================================
    exit a script file back to the REPL
        useful for julia-notebook stlye script files

    author:     merlinr@ copied from discourse somewhere
 =============================================================================#

"""
    stop_return_to_repl_or_shell(message="𝖬𝖤𝖲𝖲𝖠𝖦𝖤: 𝖤𝖭𝖣 𝖮𝖥 𝖫𝖨𝖭𝖤")

Just put a stop to the script without huge stack traces. Its a hack.

```jldoctest
# Example
julia> include("my_file_i_want_to_stop_at_some_point.jl")
ERROR: LoadError: "𝖬𝖤𝖲𝖲𝖠𝖦𝖤: 𝖤𝖭𝖣 𝖮𝖥 𝖫𝖨𝖭𝖤"
```
"""
stop_return_to_repl_or_shell(message="𝖬𝖤𝖲𝖲𝖠𝖦𝖤: 𝖤𝖭𝖣 𝖮𝖥 𝖫𝖨𝖭𝖤") = throw(StopException(message))

struct StopException{T}
    S::T
end

function Base.showerror(io::IO, ex::StopException, bt; backtrace=true)
    Base.with_output_color(get(io, :color, false) ? :green : :nothing, io) do io
        showerror(io, ex.S)
    end
end
