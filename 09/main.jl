function part1(filename)
    getId = x->(x-1)÷2
    function addToAvailableQueue!(i, queue)
        nAdds = input[i] |> (f->parse(Int, f))
        addNumber = getId(i)
        for _ in 1:nAdds
            push!(queue, addNumber)
        end
    end

    score = 0
    input = read(filename, String)
    # the first index starts at the second number in the input
    i1 = 1
    # the second index starts at the last number in the input
    i2 = length(input)

    scoreIndex = 0
    available = []
    finished = false
    while !finished
        # step 1: add scores for odd indices
        nAdd = input[i1] |> (f->parse(Int, f))
        for _ in 1:nAdd
            val = getId(i1)
            # finished if the value you are currently has items that are still in the queue
            if val in available && !isempty(available)
                finished = true
                break
            end
            score += scoreIndex * val
            scoreIndex += 1
            # println("1st -- $(val), score: $(score), i1: $(i1), i2: $(i2)")
        end
        i1 += 1

        # step 2: fill blank spaces from end
        nBlank = input[i1] |> (f->parse(Int, f))
        # add available numbers to the queue
        if isempty(available)
            addToAvailableQueue!(i2, available)
        end

        while nBlank > 0
            val = pop!(available)
            score += scoreIndex * val
            scoreIndex += 1
            # println("2nd -- $(val), score: $(score), i1: $(i1), i2: $(i2)")
            nBlank -= 1
            # ran out of items at end, add the next ones, continue until no more blanks
            if isempty(available)
                i2 -= 2
                # cannot add more items if i1 is now greater than i2, effectively a way to tell if there are no more spaces left
                if i1 > i2
                    # println("finished")
                    finished = true
                    break
                else
                    addToAvailableQueue!(i2, available)
                end
            end
        end
        
        # first index increment for next iteration -- starting over at step 1
        i1 += 1
    end

    println("Score is $(score)")
end 





@time part1("09/input.txt")