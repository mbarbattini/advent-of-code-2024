function part1(filename)
nRows = 0
nCols = 0
for l in readlines(filename)
    nCols = length(l)
    nRows += 1
end

grid = fill('.', (nRows, nCols))

i = 0
for line in readlines(filename)
    i += 1
    j = 0
    for c in line
        j += 1
        grid[i,j] = c
    end 
end

stations::Set{Tuple{Char, Int, Int}} = Set()

for i in 1:size(grid)[1]
    for j in 1:size(grid)[2]
        c = grid[i,j]
        if c != '.'
            _station = (c, i, j)
            push!(stations, _station)
        end
    end
end

function inBounds(i, j)
    return i >= 1 && i <= nRows && j >= 1 && j <= nCols
end


uniqueAntinodes = Set()
for (i, s1) in enumerate(stations)
    for (j, s2) in enumerate(stations)
        # skip comparison to self
        if s1 == s2
            continue
        end
        if s1[1] == s2[1]
            # create a vector from station i to station j
            distanceI = s2[2] - s1[2]
            distanceJ = s2[3] - s1[3]
            displacementVector = [distanceI, distanceJ]
            # check if there is another station 2 times displacementVector away
            checkI = s1[2] + 2*displacementVector[1]
            checkJ = s1[3] + 2*displacementVector[2]
            if inBounds(checkI, checkJ)
                push!(uniqueAntinodes, (checkI, checkJ))
            end
        end
    end
end

println("Score is $(length(uniqueAntinodes))")

end

part1("08/input.txt")


function part2(filename)
nRows = 0
nCols = 0
for l in readlines(filename)
    nCols = length(l)
    nRows += 1
end

grid = fill('.', (nRows, nCols))

i = 0
for line in readlines(filename)
    i += 1
    j = 0
    for c in line
        j += 1
        grid[i,j] = c
    end 
end

stations::Set{Tuple{Char, Int, Int}} = Set()

for i in 1:size(grid)[1]
    for j in 1:size(grid)[2]
        c = grid[i,j]
        if c != '.'
            _station = (c, i, j)
            push!(stations, _station)
        end
    end
end

function inBounds(i, j)
    return i >= 1 && i <= nRows && j >= 1 && j <= nCols
end

function checkHarmonics(i, j, di, dj)
    if inBounds(i, j) || return
        push!(uniqueAntinodes, (i, j))
        checkHarmonics(i+di, j+dj, di, dj)
    end
end

uniqueAntinodes = Set()
for (i, s1) in enumerate(stations)
    for (j, s2) in enumerate(stations)
        # skip comparison to self
        if s1 == s2
            continue
        end
        if s1[1] == s2[1]
            # create a vector from station i to station j
            distanceI = s2[2] - s1[2]
            distanceJ = s2[3] - s1[3]
            displacementVector = [distanceI, distanceJ]
            checkHarmonics(s1[2], s1[3], displacementVector[1], displacementVector[2])
        end
    end
end


println("Score is $(length(uniqueAntinodes))")

end

part2(raw"08/input.txt")