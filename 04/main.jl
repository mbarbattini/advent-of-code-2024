function part1(filename)
    nCols = 0
    nRows = 0
    for line in readlines(filename)
        nCols = length(line)
        nRows += 1
    end

    grid = fill('.', nRows, nCols)

    i = 0
    for line in readlines(filename)
        i += 1
        j = 0
        for c in line
            j += 1
            grid[i,j] = c
        end 
    end

    # for i in 1:size(grid)[1]
    #     for j in 1:size(grid)[2]
    #         print("$(grid[i,j])  ")
    #     end
    #     print("\n\n")
    # end

    prevMap = Dict([
        ('X', '.'),
        ('M', 'X'),
        ('A', 'M'),
        ('S', 'A'),
    ])

    validIndices = []

    function inBounds(i, j)
        return i >= 1 && i <= nRows && j >= 1 && j <= nCols
    end

    function check(i, j; prev='.', direction="left", count=1)
        if direction == "left"
            i -= 1
        elseif direction == "right"
            i += 1
        elseif direction == "down"
            j -= 1
        elseif direction == "up"
            j += 1
        elseif direction == "up_right"
            i += 1
            j += 1
        elseif direction == "up_left"
            i -= 1
            j += 1
        elseif direction == "down_right"
            i += 1
            j -= 1
        elseif direction == "down_left"
            i -= 1
            j -= 1
        end
        if count == 4
            return 1
        end
        if !inBounds(i,j)
            return 0
        end
        current = grid[i,j]
        if prevMap[current] == prev
            return check(i, j; prev=current, direction, count=count+1)
        else
            # no continuation
            return 0
        end
    end


    score = 0
    for i in 1:size(grid)[1]
        for j in 1:size(grid)[2]
            c = grid[i,j]
            if c == 'X'
                scoreLeft = check(i, j, prev='X', direction="left")
                if scoreLeft == 1
                    push!(validIndices, (i,j), (i-1,j), (i-2,j), (i-3,j))
                    score += 1
                    println("($(i),$(j)) left")
                end
                scoreRight = check(i, j, prev='X', direction="right")
                if scoreRight == 1
                    push!(validIndices, (i,j), (i+1,j), (i+2,j), (i+3,j))
                    score += 1
                    println("($(i),$(j)) right")
                end
                scoreUp = check(i, j, prev='X', direction="up")
                if scoreUp == 1
                    push!(validIndices, (i,j), (i,j+1), (i,j+2), (i,j+3))
                    score += 1
                    println("($(i),$(j)) up")
                end
                scoreDown = check(i, j, prev='X', direction="down")
                if scoreDown == 1
                    push!(validIndices, (i,j), (i,j-1), (i,j-2), (i,j-3))
                    score += 1
                    println("($(i),$(j)) down")
                end
                scoreUpRight = check(i, j, prev='X', direction="up_right")
                if scoreUpRight == 1
                    push!(validIndices, (i,j), (i+1,j+1), (i+2,j+2), (i+3,j+3))
                    score += 1
                    println("($(i),$(j)) up right")
                end
                scoreUpLeft = check(i, j, prev='X', direction="up_left")
                if scoreUpLeft == 1
                    push!(validIndices, (i,j), (i-1,j+1), (i-2,j+2), (i-3,j+3))
                    score += 1
                    println("($(i),$(j)) up left")
                end
                scoreDownRight = check(i, j, prev='X', direction="down_right")
                if scoreDownRight == 1
                    push!(validIndices, (i,j), (i+1,j-1), (i+2,j-2), (i+3,j-3))
                    score += 1
                    println("($(i),$(j)) down right")
                end
                scoreDownLeft = check(i, j, prev='X', direction="down_left")
                if scoreDownLeft == 1
                    push!(validIndices, (i,j), (i-1,j-1), (i-2,j-2), (i-3,j-3))
                    score += 1
                    println("($(i),$(j)) down left")
                end
            end
        end
    end

    println("Score: $(score)")

    println("")
    for i in 1:size(grid)[1]
        for j in 1:size(grid)[2]
            if (i,j) in validIndices
                print("x")
            else
                print(".")
            end
        end
        print("\n")
    end
end

@time part1(raw"04/input.txt")


function part2(filename)
    nCols = 0
    nRows = 0
    for line in readlines(filename)
        nCols = length(line)
        nRows += 1
    end

    grid = fill('.', nRows, nCols)

    i = 0
    for line in readlines(filename)
        i += 1
        j = 0
        for c in line
            j += 1
            grid[i,j] = c
        end 
    end
    score = 0
    for i in 1:size(grid)[1]
        for j in 1:size(grid)[2]
            c = grid[i,j]
            if c == 'A'
                if i == 1 || i == nRows || j == 1 || j == nCols
                    continue
                end
                cor1 = grid[i-1,j+1]
                cor2 = grid[i+1,j+1]
                cor3 = grid[i-1,j-1]
                cor4 = grid[i+1,j-1]
                if cor1 == 'M' && cor2 == 'M' && cor3 == 'S' && cor4 == 'S'
                    score += 1
                elseif cor1 == 'M' && cor3 == 'M' && cor2 == 'S' && cor4 == 'S'
                    score += 1
                elseif cor3 == 'M' && cor4 == 'M' && cor1 == 'S' && cor2 == 'S'
                    score += 1
                elseif cor4 == 'M' && cor2 == 'M' && cor1 == 'S' && cor3 == 'S'
                    score += 1
                end
            end
        end
    end

    println("score is $(score)")
end

@time part2(raw"04/input.txt")