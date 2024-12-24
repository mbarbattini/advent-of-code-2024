function createGrid(filename)
    nCols = 0
    nRows = 0
    for line in readlines(filename)
        nCols = length(line)
        nRows += 1
    end

    grid = fill(0, nRows, nCols)

    i = 0
    for line in readlines(filename)
        i += 1
        j = 0
        for c in line
            j += 1
            grid[i,j] = parse(Int, c)
        end 
    end
    return grid, nRows, nCols
end


function solve(filename; part2=false)

    function inBounds(i, j)
        return 1 <= i <= nRows && 1 <= j <= nCols
    end

    function search(_i,_j)
        needToVisit = []
        visitedNines = []
        _score = 0
        push!(needToVisit, (_i,_j))
        while !isempty(needToVisit)
            i, j = pop!(needToVisit)
            current = grid[i, j]
            if current == 9
                if part2
                    _score += 1
                else
                    if !((i,j) in visitedNines)
                        _score += 1
                        push!(visitedNines, (i,j))
                    end
                end
            end
            if inBounds(i+1,j) && grid[i+1,j] - current == 1
                push!(needToVisit, (i+1,j))
            end
            if inBounds(i-1,j) && grid[i-1,j] - current == 1
                push!(needToVisit, (i-1,j))
            end
            if inBounds(i, j+1) && grid[i,j+1] - current == 1
                push!(needToVisit, (i,j+1))
            end
            if inBounds(i,j-1) && grid[i,j-1] - current == 1
                push!(needToVisit, (i,j-1))
            end
        end
        return _score
    end

    score = 0 
    grid, nRows, nCols = createGrid(filename)

    for i in 1:nRows
        for j in 1:nCols
            if grid[i,j] == 0
                score += search(i,j)
            end
        end
    end


    println("Score is $(score)")
end

solve("10/input.txt")
solve("10/input.txt", part2=true)
