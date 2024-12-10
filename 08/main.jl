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

for i in 1:size(grid)[1]
    for j in 1:size(grid)[2]
        print("$(grid[i,j])")
    end
    print("\n")
end

end

part1("08/input.txt")