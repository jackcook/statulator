module Statulator

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
            println("1-proportion Z-interval")
        elseif q3 == "2"
            println("2-proportion Z-interval")
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
