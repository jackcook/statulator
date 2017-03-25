using Distributions

function one_prop_z_int(p, n, lvl)
    distribution = Normal()

    if n * p < 10 || n * (1 - p) < 10
        # conditions not met, use t-distribution
        println("Conditions were not met, using t-distribution...\n")
        distribution = TDist(n - 1)
    end

    standard_error = sqrt((p * (1-p)) / n)
    critical_value = quantile(distribution, lvl + (1 - lvl) / 2)

    lowest_value = round(p - critical_value * standard_error, 4)
    highest_value = round(p + critical_value * standard_error, 4)

    println("The interval is (", lowest_value, ", ", highest_value, ")")
    println("We can state with ", (lvl*100), "% confidence that the true proportion lies between ", lowest_value, " and ", highest_value, ".")
end

function two_prop_z_int(p1, p2, n1, n2, lvl)
    standard_error = sqrt(((p1 * (1-p1)) / n1) + ((p2 * (1-p2)) / n2))

    standard_normal = Normal()
    critical_value = quantile(standard_normal, lvl + (1 - lvl) / 2)

    lowest_value = round((p1-p2) - critical_value * standard_error, 4)
    highest_value = round((p1-p2) + critical_value * standard_error, 4)

    println("The interval is (", lowest_value, ", ", highest_value, ")")
    println("In other words, You are ", (lvl*100), "% percent likely to have the true proportion difference lie between", lowest_value, "and", highest_value, ".")
end

function one_prop_z_test(p, psample, n, alpha, prop)
    standard_error = sqrt((p * (1-p)) / n)

    standard_normal = Normal()
    critical_value = quantile(standard_normal, (psample - p) / standard_error)

    # probability =
    # println
end
