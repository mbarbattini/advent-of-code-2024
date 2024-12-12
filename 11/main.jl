function applyRules(inputArr, calcDict)
    finalArr = []
    for s in inputArr
        # check if this number has been calculated before
        if haskey(calcDict, s)
            transform = calcDict[s]
            if length(transform) == 2
                push!(finalArr, transform[1])
                push!(finalArr, transform[2])
            else
                push!(finalArr, transform)
            end
            continue
        end

        number = parse(Int, s)
        if number == 0
            push!(finalArr, "1")
            calcDict[s] = ("1")
        elseif length(s) % 2 == 0
            numDigits = length(s)
            middleIndexLeftSide = floor(numDigits / 2) |> Int
            left = s[1:middleIndexLeftSide]
            right = s[middleIndexLeftSide+1:end]
            left = string(parse(Int, left))
            right = string(parse(Int, right))

            push!(finalArr, strip(left))
            push!(finalArr, strip(right))
            calcDict[s] = (left, right)
        else
            newNumber = 2024 * number
            push!(finalArr, string(newNumber))
            calcDict[s] = (string(newNumber))
        end
    end
    return finalArr
end

function extrapolate(input; level=1)
    for i in 1:level
        input = applyRules(input, Dict())
    end
    return input
end

extrapolate(["22"], level=15)

function part1(filename)
    input = open(filename) |> (f->read(f, String))

    calcDict = Dict()
    finalArr = collect(split(input))
    for i in 1:75
        finalArr = applyRules(finalArr, calcDict)

        println("$(i): unqiue rules: $(length(calcDict))")
        println("    total stones: $(length(finalArr))")
    end

    println(length(finalArr))
end

@time part1(raw"11/example.txt")
