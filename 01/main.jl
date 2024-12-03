using StatsBase

function part1()
    file = readlines("1/input.txt");

    leftArr = Vector{Int}()
    rightArr = Vector{Int}()
    for l in file
        arr = split(l)
        left = arr[1]
        right = arr[2]
        push!(leftArr, parse(Int, left))
        push!(rightArr, parse(Int, right))
    end

    sortedLeft = sort(leftArr)
    sortedRight = sort(rightArr)

    score = 0
    for i in 1:length(sortedLeft)
        difference = abs(sortedRight[i] - sortedLeft[i])
        println(difference)
        score += difference

    end
    score
end

part1()

function get_unique_items(arr)
    unique_map = Dict{Int, Int}()

    for ele in arr
        if haskey(unique_map, ele)
            unique_map[ele] += 1
        else 
            unique_map[ele] = 1
        end
    end
    return unique_map
end




function part2()
    file = readlines("1/input.txt");
    # file = readlines("1/example.txt");

    leftArr = Vector{Int}()
    rightArr = Vector{Int}()
    for l in file
        arr = split(l)
        left = arr[1]
        right = arr[2]
        push!(leftArr, parse(Int, left))
        push!(rightArr, parse(Int, right))
    end

    score = 0
    # USE BUILT IN FUNCTION FROM StatsBase
    # uniqueMap = countmap(rightArr)

    # USE OWN FUNCTION
    uniqueMap = get_unique_items(rightArr)

    for l in leftArr
        if haskey(uniqueMap, l)
            _score = l * uniqueMap[l]
            println(_score)
            score += _score
        end
    end
    score
end


part2()

