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
            p = parse(Float64, input("What is your population proportion? "))
            psample = parse(Float64, input("What is your sample proportion?"))
            n = parse(Float64, input("What is your sample size? "))
            alpha = parse(Float64, input("What is your alpha level?"))
            prop = parse(Float64, input("Is your Alternate hypothesis '!=','>', or '<'?"))
            one_prop_z_test(p, psample, n, alpha, prop)
        elseif q3 == "2"
            p1 = parse(Float64, input("What is your first population proportion? "))
            psample1 = parse(Float64, input("What is your first sample proportion?"))
            n1 = parse(Float64, input("What is your first sample size? "))
            p2 = parse(Float64, input("What is your second population proportion? "))
            psample2 = parse(Float64, input("What is your second sample proportion?"))
            n2 = parse(Float64, input("What is your second sample size? "))
            alpha = parse(Float64, input("What is your alpha level?"))
            prop = parse(Float64, input("Is your Alternate hypothesis '!=','>', or '<'?"))
            one_prop_z_test(p1, psample1, n1, p2, psample2, n2, alpha, prop)
        end
    elseif q2 == "i"
        if q3 == "1"
            p = 0
            n = 0
            lvl = 0

            try
                p = parse(Float64, input("What is your sample proportion? "))
                n = parse(Float64, input("What is your sample size? "))
                lvl = parse(Float64, input("What is your needed confidence level? (in proportion) "))
            catch
                println("You must enter a numeric value.")
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
                println("You must enter a numeric value.")
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
            println("Z-interval")
        elseif q3 == "2"
            println("2-proportion Z-interval")
        end
    end
end

end
