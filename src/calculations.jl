using Distributions

include("confidence_interval.jl")

function one_prop_z_int(p, n, lvl)
    distribution = Normal()

    if n * p < 10 || n * (1 - p) < 10
        println("Conditions weren't met, using t-distribution...\n")
        distribution = TDist(n - 1)
    end

    standard_error = sqrt((p * (1-p)) / n)
    critical_value = quantile(distribution, lvl + (1 - lvl) / 2)

    lowest_value = round(p - critical_value * standard_error, 4)
    highest_value = round(p + critical_value * standard_error, 4)

    return ConfidenceInterval(lowest_value, highest_value)
end

function one_prop_z_test(p, p0, n, alpha, alt)
    distribution = Normal(p0, sqrt((p0 * (1-p0)) / n))

    if n * p < 10 || n * (1 - p) < 10
        println("Conditions weren't met, using t-distribution...\n")
        distribution = TDist(1)
    end

    if alt == "<"
        return round(cdf(distribution, p), 4)
    elseif alt == ">"
        return round(1 - cdf(distribution, p), 4)
    elseif alt == "!="
        if p > p0
            return round(2 * (1 - cdf(distribution, p)), 4)
        else
            return round(2 * cdf(distribution, p), 4)
        end
    else
        return -1
    end
end

function two_prop_z_int(p1, n1, p2, n2, lvl)
    standard_error = sqrt(((p1 * (1-p1)) / n1) + ((p2 * (1-p2)) / n2))

    standard_normal = Normal()
    critical_value = quantile(standard_normal, lvl + (1 - lvl) / 2)

    lowest_value = round((p1-p2) - critical_value * standard_error, 4)
    highest_value = round((p1-p2) + critical_value * standard_error, 4)

    return ConfidenceInterval(lowest_value, highest_value)
end
