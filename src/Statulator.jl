module Statulator

include("calculations.jl")

function input(prompt::AbstractString="")
    print(prompt)
    return chomp(readline())
end

q1 = input("Is this is a problem of sample proportions or means? [p/m] ")
q2 = input("Do you want to run a test or create an interval? [t/i] ")
q3 = input("How many proportions are you working with? [1/2] ")

if q1 == "p"
    if q2 == "t"
        if q3 == "1"
            println("1-proportion Z-test")
        elseif q3 == "2"
            println("2-proportion Z-test")
        end
    elseif q2 == "i"
        if q3 == "1"
            p = parse(Float64, input("What is your sample proportion? "))
            n = parse(Float64, input("What is your sample size? "))
            lvl = parse(Float64, input("What is your needed confidence level? "))
            one_prop_z_int(p, n, lvl)
        elseif q3 == "2"
            p1 = parse(Float64, input("What is your first sample proportion? "))
            n1 = parse(Float64, input("What is your first sample size? "))
            p2 = parse(Float64, input("What is your second sample proportion? "))
            n2 = parse(Float64, input("What is your second sample size? "))
            lvl = parse(Float64, input("What is your needed confidence level? "))
            two_prop_z_int(p1, n1, p2, n2, lvl)
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
