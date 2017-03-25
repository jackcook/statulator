using Distributions

function one_prop_z_int(p, n, lvl)
    standard_error = sqrt((p * (1-p)) / n)

    standard_normal = Normal()
    critical_value = quantile(standard_normal, lvl + (1 - lvl) / 2)

    lowest_value = round(p - critical_value * standard_error, 4)
    highest_value = round(p + critical_value * standard_error, 4)

    println("The interval is (", lowest_value, ", ", highest_value, ")")
    println("In other words, You are", lvl "percent likely to have the true
    proportion lie between", lowest_value "and" highest_value)
end

function two_prop_z_int(p1, p2, n1, n2, lvl)
    standard_error = sqrt(((p1 * (1-p1)) / n1)+((p2 * (1-p2)) / n2)))

    standard_normal = Normal()
    critical_value = quantile(standard_normal, lvl + (1 - lvl) / 2)

    lowest_value = round(p - critical_value * standard_error, 4)
    highest_value = round(p + critical_value * standard_error, 4)

    println("The interval is (", lowest_value, ", ", highest_value, ")")
    println("In other words, You are", lvl "percent likely to have the true
    proportion difference lie between", lowest_value "and" highest_value)
end