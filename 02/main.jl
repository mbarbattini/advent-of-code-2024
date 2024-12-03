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
    println("Total score is $(score)")
end

part1(raw"02/input.txt")

function rule1(a, b)
    return abs(a - b) <= 3
end

function rule2(a, b, rule)
    return sign(b-a) == rule
end

function part2(filepath)
    score = 0
    for line in readlines(filepath)
        nums = split(line)
        nums = [parse(Int, _n) for _n in nums]
        
        # first rule
        validCardRule1 = true
        signRule = nothing
        nSkips1 = 0
        rule1Skip = false
        rule2Skip = false
        for i in 1:length(nums) - 1
            j = i+1
            difference = nums[j] - nums[i]
            signDiff = sign(difference)
            if isnothing(signRule)
                signRule = signDiff
            end
            if signRule != signDiff 
                # try to fix by looking at the next value in the array
                # if it's good, then can move on, if not it is not valid and we can stop
                if i == length(nums)-1
                    # at the end and still valid, can just delete the last number, so this is a valid card

                    nSkips1 += 1
                    # rule1Skip = true
                else
                    nextSign = sign(nums[j+1] - nums[i])
                    if nextSign != signRule && !rule1(nums[i], nums[j+1])
                        validCardRule1 = false
                        break
                    else
                        # valid card with a skip
                        nSkips1 += 1
                    end
                end
            end
        end
        validCardRule2 = true
        nSkips2 = 0
        for i in 1:length(nums) - 1
            j = i+1
            difference = nums[j] - nums[i]
            if abs(difference) > 3 || abs(difference) < 1
                if i == length(nums)-1
                    # at the end and still valid, can just delete the last number, so this is a valid card
                    nSkips2 += 1
                else
                    nextDiff = nums[j+1] - nums[i]
                    if abs(nextDiff) > 3 || abs(nextDiff) < 1
                        validCardRule2 = false
                        break
                    else
                        # valid card with a skip
                        nSkips2 += 1
                        # rule2Skip = true
                    end
                end
            end
        end
        if validCardRule1 && nSkips1 <= 1 && validCardRule2 && nSkips2 <= 1
            score += 1
            println("valid: $(nums)")
        else
            println("invalid: $(nums) with $(nSkips1),$(nSkips2) skips")
        end 
    end
    println("Total score is $(score)")
end

part2(raw"02/input.txt")

rule1(32, 37)

# ONLINE SOLUTION
lines = [parse.(Int, split(line)) for line in readlines("02/input.txt")]
safe(lista) = all(((a < b && lista[1] < lista[2]) || (a > b && lista[1] > lista[2])) && abs(a - b) <= 3 for (a, b) in zip(lista, lista[2:end]))
safe2(lista) = safe(lista) || any(safe(vcat(lista[1:i-1], lista[i+1:end])) for i in 1:length(lista)) ? 1 : 0
println(sum(safe(line) for line in lines))
println(sum(safe2(line) for line in lines))