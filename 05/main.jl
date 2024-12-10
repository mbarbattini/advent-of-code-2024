function part1(filename)
    input = open(filename, "r") |> (f->read(f, String))
    rulesRaw, updates = split(input, "\n\n")

    rules::Array{Tuple} = []
    for l in split(rulesRaw)
        before, after = split(l, "|")
        # before = parse(Int64, left)
        # after = parse(Int64, right)
        push!(rules, (before, after))
    end

    score = 0
    for manual in split(updates)
        pagesReverse = reverse(split(manual, ","))
        valid = true
        for (i, page) in enumerate(pagesReverse)
            for rule in rules
                if page == rule[1]
                    for j in i+1:length(pagesReverse)
                        if pagesReverse[j] == rule[2]
                            valid = false
                        end
                    end
                end
            end
        end
        middleIndex = floor(length(pagesReverse) / 2) + 1
        if valid
            score += parse(Int64, pagesReverse[Int(middleIndex)])
        end
    end
    println("Score is $(score)")
end

part1(raw"05/input.txt")



function correctPart2(rules, numbers)
    # while the numbers still need to be sorted
    #   for each page i
    #     if this page appears in the rules
    #       for each page j that is after page i 
    #         if page j appears in the rules of page i
    #           swap page j and page i (because the rules say pages after need to become to pages before)
    #             move on to the next iter of page i
    cont = true
    while cont
        cont = false
        for i in eachindex(numbers)
            for j in 1:i-1
                if haskey(rules, numbers[i]) && numbers[j] in rules[numbers[i]]
                    numbers[i], numbers[j] = numbers[j], numbers[i]
                    cont = true
                end
            end
        end
    end
    println(numbers)
    # return the middle index value
    middleIndex = Int(floor(length(numbers) / 2) + 1)
    return numbers[middleIndex]
end

function part2(filename)
    score = 0
    input = open(filename, "r") |> (f->read(f, String))
    rulesRaw, updates = split(input, "\n\n")

    rulesPart1::Array{Tuple} = []
    for l in split(rulesRaw)
        before, after = split(l, "|")
        push!(rulesPart1, (before, after))
    end

    rulesDict = Dict{Int, Vector{Int}}()
    for l in split(rulesRaw)
        before, after = split(l, "|")
        before = parse(Int, before)
        after = parse(Int, after)
        if !haskey(rulesDict, before)
            rulesDict[before] = [after]
        else
            push!(rulesDict[before], after)
        end
    end

    for manual in split(updates)
        pages = [parse(Int64, x) for x in split(manual, ",")]

        pagesReverse = reverse(split(manual, ","))
        valid = true
        for (i, page) in enumerate(pagesReverse)
            for rule in rulesPart1
                if page == rule[1]
                    for j in i+1:length(pagesReverse)
                        if pagesReverse[j] == rule[2]
                            valid = false
                        end
                    end
                end
            end
        end
        # only do this for the invalid manuals from the first part
        if !valid
            score += correctPart2(rulesDict, pages)
        end
        println("------")
    end
    println("Score is $(score)")
end

part2(raw"05/input.txt")