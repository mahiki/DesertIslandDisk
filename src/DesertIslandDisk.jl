module DesertIslandDisk


export  @tostring
export  @remindme
export  printschema
export  stop_script_exection_and_return_to_repl_or_shell

greet() = print("Hello World!")

include("tostring.jl")
include("remindme.jl")
include("printschema.jl")
include("repl_script_end_gracefully.jl")


end # module
