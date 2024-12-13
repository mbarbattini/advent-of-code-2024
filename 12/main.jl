using DataStructures

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

    function inBounds(i,j)
        return i >= 1 && i <= nRows && j >= 1 && j <= nCols
    end

    visited = []
    score = 0

    Q = Queue{Tuple}()
    for i in 1:nRows
        for j in 1:nCols
            if !((i,j) in visited)
                landPlots = []
                perimeter = 0
                landChar = grid[i,j]
                enqueue!(Q, (landChar,i,j))
                # # flood fill
                while !isempty(Q)
                    n = Base.first(Q)
                    dequeue!(Q)
                    # check they are the same char
                    if n[1] == landChar
                        if ((n[2], n[3]) in visited)
                            continue
                        end
                        # add this coordinate to the score array
                        push!(landPlots, (n[2], n[3]))
                        push!(visited, (n[2],n[3]))
                        _i = n[2]+1
                        _j = n[3]
                        if inBounds(_i,_j)
                            enqueue!(Q, (grid[_i,_j], _i, _j))
                        else
                            perimeter += 1 # out of bounds
                        end
                        _i = n[2]-1
                        _j = n[3]
                        if inBounds(_i,_j)
                            enqueue!(Q, (grid[_i,_j], _i, _j))
                        else
                            perimeter += 1 # out of bounds
                        end
                        _i = n[2]
                        _j = n[3]+1
                        if inBounds(_i,_j)
                            enqueue!(Q, (grid[_i,_j], _i, _j))
                        else
                            perimeter += 1 # out of bounds
                        end
                        _i = n[2]
                        _j = n[3]-1
                        if inBounds(_i,_j)
                            enqueue!(Q, (grid[_i,_j], _i, _j))
                        else
                            perimeter += 1 # out of bounds
                        end
                    else
                        perimeter += 1 # checking cell in bounds and not visited, but its a different letter, so increase perimeter by 1
                    end
                end
                area = length(landPlots)
                score += area * perimeter
            end
        end
    end
    println("Score is $(score)")
end

@time part1("12/input.txt")



