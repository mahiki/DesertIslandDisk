#==============================================================================
    run a test on the REPL and get a "PASS" if its OK
    there is an existing @test macro, mine should be sweeter

    package:    DesertIslandDisk
    tested:     PASS
    depend:     NO
    author:     mahiki@
 =============================================================================#

"""
    @test

Return the variable, function, Symbol, object, et al name as a string.

@tostring(arg::Any)

# Examples
```jldoctest
julia> a = 55;
julia> bingo = "I'm the new sherrif";




macro assert(ex)
           return :( $ex ? nothing : throw(AssertionError($(string(ex)))) )
       end
