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


function part1(filename)
    input = open(filename) |> (f->read(f, String))

    calcDict = Dict()
    finalArr = collect(split(input))
    for i in 1:25
        finalArr = applyRules(finalArr, calcDict)

        println("$(i): unqiue rules: $(length(calcDict))")
        println("    total stones: $(length(finalArr))")
    end

    println(length(finalArr))
end

@time part1(raw"11/example.txt")

"""
Dynamic Programming Solution
From https://github.com/fmarotta/AoC/blob/main/2024/day11/run.jl

Bottom up solution: start at level 75 and work your way up to level 0

Store results of inputs and their levels
Ex. ("544", 13) => 134
    input "544" at level 13 will produce 134 after it is recursively called out to level 75

Don't repeat calculations that you don't need to do

"""
function numberStones(input; level=75, calcDict=Dict())
    if level==0
        return 1
    end
    if !((input, level) in keys(calcDict))
        calcDict[(input, level)] = (
            if input == "0"
                numberStones("1", level=level-1, calcDict=calcDict)
            elseif length(input) % 2 == 0
                numDigits = length(input)
                middleIndexLeftSide = floor(numDigits / 2) |> Int
                left = input[1:middleIndexLeftSide]
                right = input[middleIndexLeftSide+1:end]
                left = parse(Int, left) |> string |> strip
                right = parse(Int, right) |> string |> strip
                numberStones(left, level=level-1, calcDict=calcDict) + numberStones(right, level=level-1, calcDict=calcDict)
            else
                numInput = parse(Int, input)
                newInput = string(numInput*2024)
                numberStones(newInput, level=level-1, calcDict=calcDict)
            end
        )
    end
    # println("($(input), $(level)) => $(calcDict[(input, level)])")
    # println("total rules: $(length(calcDict))")
    return calcDict[(input, level)] # this is a number, but it be greater than 1 because it follows the input up to level 75
end

function part2(filename)

    input = open(filename) |> (f->read(f, String))

    score = 0
    for number in split(input)
        score += numberStones(number)
    end

    println("Score is $(score)")

end

@time part2(raw"11/input.txt")