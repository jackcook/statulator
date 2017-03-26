using Base.Test

include("../src/calculations.jl")

@test one_prop_z_int(0.5, 100, 0.95) == ConfidenceInterval(0.402, 0.598)

@test one_prop_z_test(0.45, 0.5, 100, 0.95, "!=") == 0.3173
@test one_prop_z_test(0.5, 0.45, 100, 0.95, "!=") == 0.3149
@test one_prop_z_test(0.45, 0.5, 100, 0.95, "<") == 0.1587
@test one_prop_z_test(0.45, 0.5, 100, 0.95, ">") == 0.8413
@test one_prop_z_test(0.45, 0.5, 100, 0.95, "asdf") == -1

@test two_prop_z_int(0.5, 100, 0.7, 200, 0.95) == ConfidenceInterval(-0.3168, -0.0832)

@test two_prop_z_test(0.5, 100, 0.6, 200, 0.95, "!=") == 0.0994
@test two_prop_z_test(0.6, 200, 0.5, 100, 0.95, "!=") == 0.0994
@test two_prop_z_test(0.5, 100, 0.6, 200, 0.95, ">") == 0.9503
@test two_prop_z_test(0.5, 100, 0.6, 200, 0.95, "<") == 0.0497

@test z_interval(50, 5, 100, 0.95) == ConfidenceInterval(49.02, 50.98)
# n < 30, t-distribution should be used
@test z_interval(50, 5, 20, 0.95) == ConfidenceInterval(47.6599, 52.3401)

@test z_test(49, 50, 5, 100, 0.95, "!=") == 0.0455
@test z_test(50, 49, 5, 100, 0.95, "!=") == 0.0455
@test z_test(49, 50, 5, 100, 0.95, "<") == 0.0228
@test z_test(51, 50, 5, 100, 0.95, ">") == 0.0228

@test two_sample_z_interval(60, 5, 100, 50, 5, 100, 0.95) == ConfidenceInterval(8.6141, 11.3859)
# n1 < 30, t-distribution should be used
@test two_sample_z_interval(6, 1, 10, 50, 5, 100, 0.95) == ConfidenceInterval(-47.1528, -40.8472)

@test two_sample_z_test(51, 5, 100, 50, 5, 100, 0.95, ">") == 0.0786
@test two_sample_z_test(51, 5, 100, 50, 5, 100, 0.95, "<") == 0.9214
@test two_sample_z_test(51, 5, 100, 50, 5, 100, 0.95, "!=") == 0.1573
@test two_sample_z_test(50, 5, 100, 51, 5, 100, 0.95, "!=") == 0.1573
