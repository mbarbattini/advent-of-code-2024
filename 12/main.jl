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
    landPlots = Dict()

    Q = Queue{Tuple}()
    for i in 1:nRows
        for j in 1:nCols
            if !((i,j) in visited)
                landChar = grid[i,j]
                push!(visited, (i,j))
                enqueue!(Q, (landChar,i,j))
                # # flood fill
                while !isempty(length(Q))
                    n = Base.first(Q)
                    dequeue!(Q)
                    # check they are the same char
                    if n[1] == landChar
                        # add this coordinate to the score dict
                        println("$(n[1]) @ ($(n[2]),$(n[3])) added")
                        # add west
                        _i = n[2]+1
                        _j = n[3]
                        if inBounds(_i,_j)
                            push!(visited, (_i,_j))
                            enqueue!(Q, (grid[_i,_j], _i, _j))
                        end
                        _i = n[2]-1
                        _j = n[3]
                        if inBounds(_i,_j)
                            push!(visited, (_i,_j))
                            enqueue!(Q, (grid[_i,_j], _i, _j))
                        end
                        _i = n[2]
                        _j = n[3]+1
                        if inBounds(_i,_j)
                            push!(visited, (_i,_j))
                            enqueue!(Q, (grid[_i,_j], _i, _j))
                        end
                        _i = n[2]
                        _j = n[3]-1
                        if inBounds(_i,_j)
                            push!(visited, (_i,_j))
                            enqueue!(Q, (grid[_i,_j], _i, _j))
                        end
                    end
                end
            end
        end
    end
    Q
end

part1("12/example.txt")




