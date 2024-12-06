function part1(filename)
    nCols = 0
    nRows = 0
    for line in readlines(filename)
        nCols = length(line)
        nRows += 1
    end
    nRows
    nCols

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

    prevMap = Dict([
        ('X', '.'),
        ('M', 'X'),
        ('A', 'M'),
        ('S', 'A'),
    ])

    function inBounds(i, j)
        return i >= 1 && i <= nRows && j >= 1 && j <= nCols
    end

    function checkLeft(i, j, grid; prev='.', count=1)
        if !inBounds(i, j) 
            return 0
        end
        println("left")
        current = grid[i,j]
       
        if prevMap[current] == prev
            return checkLeft(i-1, j, grid, prev=current, count=count+1)
        elseif count == 4
            return 1
        else
            # no continuation
            return 0
        end
    end

    function checkRight(i, j, grid; prev='.', count=1)
        if !inBounds(i, j) 
            return 0
        end
        println("right")
        current = grid[i,j]
        
        if prevMap[current] == prev
            return checkRight(i+1, j, grid, prev=current, count=count+1)
        elseif count == 4
            return 1
        else
            # no continuation
            return 0
        end
    end

    function checkDown(i, j, grid; prev='.', count=1)
        if !inBounds(i, j) 
            return 0
        end
        println("down")
        current = grid[i,j]
        
        if prevMap[current] == prev
            return checkDown(i, j-1, grid, prev=current, count=count+1)
        elseif count == 4
            return 1
        else
            # no continuation
            return 0
        end
    end

    function checkUp(i, j, grid; prev='.', count=1)
        
        if !inBounds(i, j) 
            return 0
        end
        println("up")
        current = grid[i,j]
        
        if prevMap[current] == prev
            return checkUp(i, j+1, grid, prev=current, count=count+1)
        elseif count == 4
            return 1
        else
            # no continuation
            return 0
        end
    end

    # function checkUpRight(i, j, grid; prev='.')
    #     if !inBounds(i, j) 
    #         return 0
    #     end
    #     println("call up right")
    #     current = grid[i,j]
        
    #     if prevMap[current] == prev
    #         return checkUpRight(i+1, j+1, grid, prev=current)
    #     elseif current == 'S' && prev == 'A'
    #         return 1
    #     else
    #         # no continuation
    #         return 0
    #     end
    # end

    # function checkUpLeft(i, j, grid; prev='.')
    #     if !inBounds(i, j) 
    #         return 0 
    #     end
    #     println("call up left")
    #     current = grid[i,j]
        
    #     if prevMap[current] == prev
    #         return checkUpLeft(i-1, j+1, grid, prev=current)
    #     elseif current == 'S' && prev == 'A'
    #         return 1
    #     else
    #         # no continuation
    #         return 0
    #     end
    # end

    # function checkDownRight(i, j, grid; prev='.')
    #     if !inBounds(i, j) 
    #         return 0
    #     end
    #     println("call down right")
    #     current = grid[i,j]
        
    #     if prevMap[current] == prev
    #         return checkDownRight(i+1, j-1, grid, prev=current)
    #     elseif current == 'S' && prev == 'A'
    #             return 1
    #     else
    #         # no continuation
    #         return 0
    #     end
    # end

    # function checkDownLeft(i, j, grid; prev='.')
    #     if !inBounds(i, j) 
    #         return 0
    #     end
    #     println("call down left")
    #     current = grid[i,j]
        
    #     if prevMap[current] == prev
    #         return checkDownLeft(i-1, j-1, grid, prev=current)
    #     elseif current == 'S' && prev == 'A'
    #         return 1
    #     else
    #         # no continuation
    #         return 0
    #     end
    # end


    score = 0
    for i in 1:size(grid)[1]
        for j in 1:size(grid)[2]
            c = grid[i,j]
            if c == 'X'
                score += checkLeft(i-1, j, grid, prev='X')
                score += checkRight(i+1, j, grid, prev='X')
                score += checkDown(i, j-1, grid, prev='X')
                score += checkUp(i+1, j+1, grid, prev='X')
                # score += checkUpLeft(i-1, j+1, grid, prev='X')
                # score += checkUpRight(i+1, j+1, grid, prev='X')
                # score += checkDownLeft(i-1, j-1, grid, prev='X')
                # score += checkDownRight(i+1, j-1, grid, prev='X')

            end
        end
    end

    println("Score: $(score)")
end

part1(raw"AdventOfCode\04\example.txt")