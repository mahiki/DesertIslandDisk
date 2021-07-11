module DesertIslandDisk


export  @tostring
export  @remindme
export  stop_script_exection_and_return_to_repl_or_shell
export  printschema

greet() = print("Hello World!")

include("tostring.jl")
include("repl_script_end_gracefully.jl")
include("remindme.jl")
include("printschema.jl")


end # module
