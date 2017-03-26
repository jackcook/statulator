using Base.Test

include("../src/calculations.jl")

@test one_prop_z_int(0.5, 100, 0.95) == ConfidenceInterval(0.402, 0.598)

@test one_prop_z_test(0.45, 0.5, 100, 0.95, "!=") == 0.3173
@test one_prop_z_test(0.5, 0.45, 100, 0.95, "!=") == 0.3149
@test one_prop_z_test(0.45, 0.5, 100, 0.95, "<") == 0.1587
@test one_prop_z_test(0.45, 0.5, 100, 0.95, ">") == 0.8413
@test one_prop_z_test(0.45, 0.5, 100, 0.95, "asdf") == -1

@test two_prop_z_int(0.5, 100, 0.7, 200, 0.95) == ConfidenceInterval(-0.3168, -0.0832)

@test z_interval(50, 5, 100, 0.95) == ConfidenceInterval(49.0079, 50.9921)
# n < 30, t-distribution should be used
@test z_interval(50, 5, 20, 0.95) == ConfidenceInterval(47.6599, 52.3401)
