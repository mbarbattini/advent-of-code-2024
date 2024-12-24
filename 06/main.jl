
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

    # for i in 1:nCols
    #     for j in 1:nRows
    #         # print("$(grid[i,j]) $(i),$(j)  ")
    #         print("$(grid[i,j])   ")
    #         if grid[i,j] == '^'
    #         end
    #     end
    #     print("\n")
    # end

    function inBounds(i, j)
        return i >= 1 && i <= nCols && j >= 1 && j <= nRows
    end

    startPosI = 0
    startPosJ = 0
    transformMovementDirection = Dict([
        ((-1,0), (0,1)),
        ((0,1), (1,0)),
        ((1,0), (0,-1)),
        ((0,-1), (-1,0))
    ])
    for i in 1:nRows 
        for j in 1:nCols 
            if grid[i,j] == '^'
                startPosI = i
                startPosJ = j
            end
        end
    end

    visited = [(startPosI, startPosJ)]
    movementDirection = (-1,0)
    checkPosI = startPosI + movementDirection[1]
    checkPosJ = startPosJ + movementDirection[2]
    currentPosI = startPosI
    currentPosJ = startPosJ
    while inBounds(checkPosI, checkPosJ)
        # println("$(currentPosI),$(currentPosJ)")
        if grid[checkPosI, checkPosJ] == '#'
            movementDirection = transformMovementDirection[movementDirection]
            checkPosI = currentPosI + movementDirection[1]
            checkPosJ = currentPosJ + movementDirection[2]
        end
        currentPosI += movementDirection[1]
        currentPosJ += movementDirection[2]
        checkPosI += movementDirection[1]
        checkPosJ += movementDirection[2]
        push!(visited, (currentPosI,currentPosJ))
    end
    println("score is $(length(Set(visited)))")
    # for i in 1:nCols
    #     for j in 1:nRows
    #         if (i,j) in visited
    #             print("X")
    #         else
    #             print("$(grid[i,j])")
    #         end
    #     end
    #     print("\n")
    # end

end


@time part1(raw"06/input.txt")