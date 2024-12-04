function part1(filepath)
    score = 0
    for line in readlines(filepath)
        nums = split(line)
        nums = [parse(Int, _n) for _n in nums]
        validCard = true
        signRule = nothing
        for i in 1:length(nums) - 1
            j = i+1
            difference = nums[j] - nums[i]
            signDiff = sign(difference)
            if isnothing(signRule)
                signRule = signDiff
            end
            if signRule != signDiff && signDiff != 0
                validCard = false
            end
            if abs(difference) > 3 || abs(difference) < 1
                validCard = false
            end
        end
        if validCard
            score += 1
        end 
    end
    println("Part 1: $(score)")
end

part1(raw"02/input.txt")

using InvertedIndices
function is_valid(nums::Array; dampener=false)::Bool
    
    valid = all(-3 .<= diff(nums) .< 0) || all(0 .< diff(nums) .<= 3)
    valid && return true

    # only consider the line below when we call the recursive case where we try to skip one of the numbers because dampener=false
    # which means we evaluate the list once, return what we get
    # if it's invalid, return false, go back up one level, since we call the recursive part with && return true, nothing happens
    # Only when we do the recursive call and get a valid does it return true, because it can be valid with 1 number skip
    !dampener && return valid

    for i in 1:length(nums)
        is_valid(nums[Not(i)]) && return true
    end
    # tried all number skips, never returned true, so this is an invalid card
    return false
end 

function part2(filepath)
    score = 0
    for line in readlines(filepath)
        nums = split(line)
        nums = [parse(Int, _n) for _n in nums]
        if is_valid(nums, dampener=true)
            score += 1
        end
    end
    print("Part2 : $(score)")
end


part2(raw"02/input.txt")  