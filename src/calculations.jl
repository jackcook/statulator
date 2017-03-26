using Distributions

include("confidence_interval.jl")

function one_prop_z_int(p, n, lvl)
    distribution = Normal()

    standard_error = sqrt((p * (1-p)) / n)
    critical_value = quantile(distribution, lvl + (1 - lvl) / 2)

    lowest_value = round(p - critical_value * standard_error, 4)
    highest_value = round(p + critical_value * standard_error, 4)

    return ConfidenceInterval(lowest_value, highest_value)
end

function one_prop_z_test(p, p0, n, alpha, alt)
    distribution = Normal(p0, sqrt((p0 * (1-p0)) / n))

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

function two_prop_z_test(p1, n1, p2, n2, alpha, alt)
    p_pooled = (p1*n1 + p2*n2) / (n1 + n2)
    distribution = Normal(0, sqrt((p_pooled/n1) + (p_pooled/n2)))

    if alt == "<"
        return round(cdf(distribution, p1-p2), 4)
    elseif alt == ">"
        return round(1 - cdf(distribution, p1-p2), 4)
    elseif alt == "!="
        if abs(p1-p2) > p_pooled
            return round(2 * (1 - cdf(distribution, p1-p2)), 4)
        else
            return round(2 * cdf(distribution, p1-p2), 4)
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

function z_interval(x̄, sx, n, lvl)
    distribution = Normal()

    if n < 30
        println("Conditions weren't met, using t-distribution...\n")
        distribution = TDist(n - 1)
    end

    standard_error = sx / sqrt(n)
    critical_value = quantile(distribution, lvl + (1 - lvl) / 2)

    lowest_value = round(x̄ - critical_value * standard_error, 4)
    highest_value = round(x̄ + critical_value * standard_error, 4)

    return ConfidenceInterval(lowest_value, highest_value)
end

function z_test(x̄, μ0, sx, n, alpha, alt)
    distribution = Normal(μ0, sx / sqrt(n))

    if alt == "<"
        return round(cdf(distribution, x̄), 4)
    elseif alt == ">"
        return round(1 - cdf(distribution, x̄), 4)
    elseif alt == "!="
        if x̄ > μ0
            return round(2 * (1 - cdf(distribution, x̄)), 4)
        else
            return round(2 * cdf(distribution, x̄), 4)
        end
    else
        return -1
    end
end
