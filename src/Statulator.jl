module Statulator

include("calculations.jl")

function input(prompt::AbstractString="")
    print(prompt)
    return chomp(readline())
end

function terminate(message::AbstractString="")
    println(message)
    exit()
 end

 q1 = input("Is this is a problem of sample proportions or means? [p/m] ")

if q1 != "p" && q1 != "m"
    terminate("You must enter 'p' for proportion or 'm' for mean.")
end

q2 = input("Do you want to run a test or create an interval? [t/i] ")

if q2 != "t" && q2 != "i"
    terminate("You must enter 't' for test or 'i' for interval.")
end

q3 = input("How many proportions are you working with? [1/2] ")

if q3 != "1" && q3 != "2"
    terminate("Only one and two proportion tests and intervals are currently supported.")
end

if q1 == "p"
    if q2 == "t"
        if q3 == "1"
            p = 0
            p0 = 0
            n = 0
            alpha = 0
            alt = ""

            try
                p = parse(Float64, input("What is your sample proportion? "))
                p0 = parse(Float64, input("What is your assumed population proportion? "))
                n = parse(Float64, input("What is your sample size? "))
                alpha = parse(Float64, input("What is your alpha level? "))
                alt = input("Is your alternate hypothesis '!=', '>', or '<'? ")
            catch
                terminate("You must enter a numeric value.")
            end

            if alt != "!=" && alt != ">" && alt != "<"
                terminate("That wasn't an option.")
            end

            p_value = one_prop_z_test(p, p0, n, alpha, alt, p_pooled)
            println("The calculated p-value is ", p_value)
            println("If the population proportion is ", p0, " then the probability of observing a sample proportion of ", p, " is ", p_value, ".")
        elseif q3 == "2"
            p1 = 0
            n1 = 0
            p2 = 0
            n2 = 0
            alpha = 0
            alt = ""

            try
                p1 = parse(Float64, input("What is your first sample proportion? "))
                n1 = parse(Float64, input("What is your first sample size? "))
                p2 = parse(Float64, input("What is your second sample proportion? "))
                n2 = parse(Float64, input("What is your second sample size? "))
                alpha = parse(Float64, input("What is your alpha level?"))
                alt = input("Is your alternate hypothesis '!=', '>', or '<'? ")
            catch
                terminate("You must enter a numeric value.")
            end

            if alt != "!=" && alt != ">" && alt != "<"
                terminate("That wasn't an option.")
            end

            p_value = two_prop_z_test(p1, n1, p2, n2, alpha, alt)
            println("The calculated p-value is ", abs(p_value))
            println("If the difference between the population proportions is 0, then the probability of observing a sample proportion difference of ", abs(p1-p2), " is ", abs(p_value), ".")


        end
    elseif q2 == "i"
        if q3 == "1"
            p = 0
            n = 0
            lvl = 0

            try
                p = parse(Float64, input("What is your sample proportion? "))
                n = parse(Float64, input("What is your sample size? "))
                lvl = parse(Float64, input("What is your needed confidence level? "))
            catch
                terminate("You must enter a numeric value.")
            end

            interval = one_prop_z_int(p, n, lvl)

            println("The interval is (", interval.lower, ", ", interval.upper, ")")
            println("We can state with ", (lvl*100), "% confidence that the true proportion lies between ", interval.lower, " and ", interval.upper, ".")
        elseif q3 == "2"
            p1 = 0
            n1 = 0
            p2 = 0
            n2 = 0
            lvl = 0

            try
                p1 = parse(Float64, input("What is your first sample proportion? "))
                n1 = parse(Float64, input("What is your first sample size? "))
                p2 = parse(Float64, input("What is your second sample proportion? "))
                n2 = parse(Float64, input("What is your second sample size? "))
                lvl = parse(Float64, input("What is your needed confidence level? (in proportion)"))
            catch
                terminate("You must enter a numeric value.")
            end

            interval = two_prop_z_int(p1, n1, p2, n2, lvl)

            println("The interval is (", interval.lower, ", ", interval.upper, ")")
            println("We can state with ", (lvl*100), "% confidence that the difference in the true proportion lies between ", interval.lower, " and ", interval.upper, ".")
        end
    end
elseif q1 == "m"
    if q2 == "t"
        if q3 == "1"
            println("Z-test")
        elseif q3 == "2"
            println("2-sample Z-test")
        end
    elseif q2 == "i"
        if q3 == "1"
            x̄ = 0
            sx = 0
            n = 0
            lvl = 0

            try
                x̄ = parse(Float64, input("What is your sample mean? "))
                sx = parse(Float64, input("What is your sample standard deviation? "))
                n = parse(Float64, input("What is your sample size? "))
                lvl = parse(Float64, input("What is your needed confidence level? "))
            catch
                terminate("You must enter a numeric value.")
            end

            interval = z_interval(x̄, sx, n, lvl)

            println("The interval is (", interval.lower, ", ", interval.upper, ")")
            println("We can state with ", (lvl*100), "% confidence that the true mean lies between ", interval.lower, " and ", interval.upper, ".")
        elseif q3 == "2"
            println("2-proportion Z-interval")
        end
    end
end

end
