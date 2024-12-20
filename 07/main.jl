"""
Depth First Search.

Use a Queue
Start on the first number and look ahead at the next one.
Add each possibility for the operators "+", "*" and add it to the queue
Go until the queue is empty
If the search index is greater than the amount of numbers, then you are at the end of the numbers, it it is equal then its good, if not equal its invalid

"""
function isvalid(numbers, target; p2=false)
    n = length(numbers)
    queue = [(2, numbers[1])]
    while !isempty(queue)
        next, val = pop!(queue)
        if next == n+1 || next == n+2 # on the last number because it would be 1 greater than vector length
            if val == target 
                # println("success! $(next), $(val)")
                return true
            end
            continue
        end
        if p2
            possibilities = [
                val + numbers[next],
                val * numbers[next],
                parse(Int, join([val, numbers[next]]))
            ]
            for p in possibilities
                if p <= target
                    push!(queue, (next+1, p))
                end
            end
        else
            possibilities = [
                val + numbers[next],
                val * numbers[next],
            ]
            for p in possibilities
                if p <= target
                    push!(queue, (next+1, p))
                end
            end
        end
    end
    return false
end

function solve(filename)
    scoreP1 = 0
    scoreP2 = 0
    for line in readlines(filename)
        target, numbers = split(line, ":")
        target = parse(Int, target)
        numbers = parse.(Int, split(numbers[2:end], " "))
        if isvalid(numbers, target, p2=false)
            scoreP1 += target
        end
        if isvalid(numbers,target,p2=true)
            scoreP2 += target
        end
    end
    return scoreP1, scoreP2
end


@time p1, p2 = solve("07/input.txt")