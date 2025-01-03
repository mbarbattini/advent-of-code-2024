function part1(filename)
    input = open(filename, "r") |> (f->read(f, String))

    allMatches = eachmatch(r"mul\(\d{1,3},\d{1,3}\)", input)

    score = 0
    for m in allMatches
        left, right = split(m.match, ",")
        cleanedLeft = replace(left, r"\D" => "") |> (f->parse(Int, f))
        cleanedRight = replace(right, r"\D" => "") |> (f->parse(Int, f))
        score += cleanedLeft * cleanedRight
        println("$(left) $(right)")
    end
    println("Total score is $(score)")
end

part1(raw"03/input.txt")

function part2(filename)
    input = open(filename, "r") |> (f->read(f, String))

    allMatches = eachmatch(r"mul\(\d{0,3},\d{1,3}\)", input)
    skipCommand = eachmatch(r"don't\(\)", input)
    performCommand = eachmatch(r"do\(\)", input)

    allMatchesArr = [m.match for m in allMatches]
    multOffsets = [m.offset for m in allMatches]
    dontOffsets = [m.offset for m in skipCommand]
    doOffsets = [m.offset for m in performCommand]

    matchIndex = 0
    score = 0
    for i in 1:length(input)
        if matchIndex == length(allMatchesArr)
            break
        end
        if i == multOffsets[matchIndex+1]
            matchIndex += 1
            # go back until you hit a do or don't command
            j = i-1
            while true
                if j == 0
                    # do the first one in the text always 
                    println("do FIRST")
                    left, right = split(allMatchesArr[matchIndex], ",")
                    cleanedLeft = replace(left, r"\D" => "") |> (f->parse(Int, f))
                    cleanedRight = replace(right, r"\D" => "") |> (f->parse(Int, f))
                    score += cleanedLeft * cleanedRight
                    println("$(allMatchesArr[matchIndex]) = $(cleanedLeft*cleanedRight)")
                    break
                elseif j in dontOffsets
                    # do not multiply this one
                    println("dont: $(j) < match index: $(multOffsets[matchIndex])")
                    break
                elseif j in doOffsets
                    # multiply this one
                    println("do")
                    left, right = split(allMatchesArr[matchIndex], ",")
                    cleanedLeft = replace(left, r"\D" => "") |> (f->parse(Int, f))
                    cleanedRight = replace(right, r"\D" => "") |> (f->parse(Int, f))
                    score += cleanedLeft * cleanedRight
                    println("$(allMatchesArr[matchIndex]) = $(cleanedLeft*cleanedRight)")
                    break
                end
                j -= 1
            end
        end
    end
    println("Score is $(score)")
end

part2(raw"03/input.txt")

