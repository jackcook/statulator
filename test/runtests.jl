using Base.Test

include("../src/calculations.jl")

@test one_prop_z_int(0.5, 100, 0.95) == ConfidenceInterval(0.402, 0.598)
@test two_prop_z_int(0.5, 100, 0.7, 200, 0.95) == ConfidenceInterval(-0.3168, -0.0832)
