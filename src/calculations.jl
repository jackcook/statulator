using Distributions

function one_prop_z_int(p, n, lvl)
    standard_error = sqrt((p * (1-p)) / n)

    standard_normal = Normal()
    critical_value = quantile(standard_normal, lvl + (1 - lvl) / 2)

    lowest_value = round(p - critical_value * standard_error, 4)
    highest_value = round(p + critical_value * standard_error, 4)

    println("The interval is (", lowest_value, ", ", highest_value, ")")
end
