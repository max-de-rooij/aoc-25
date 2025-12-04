function readsplitlines(input_file)
    open(input_file, "r") do io
    split.(readlines(io), "")
    end
end

function day04_part1(input_file="day04/inputs/day04.txt")
    lines = readsplitlines(input_file)
    counter = 0
    H = length(lines); W = length(lines[1])
    for i in 1:H, j in 1:W
        if lines[i][j] == "@"
            neighbor_count = 0
            for di in (-1,0,1), dj in (-1,0,1)
                if di != 0 || dj != 0
                    ni = i + di; nj = j + dj
                    if 1 <= ni <= H && 1 <= nj <= W && lines[ni][nj] == "@"
                        neighbor_count += 1
                    end
                end
            end

            if neighbor_count < 4
                counter += 1
            end
        end
    end
    return counter
end

function day04_part2(input_file="day04/inputs/day04.txt")
    lines = readsplitlines(input_file)
    counter = 0; removed = 1
    H = length(lines); W = length(lines[1])
    indices_to_check = [(i,j) for i in 1:H, j in 1:W][:]
    while !isempty(indices_to_check)

        i,j = pop!(indices_to_check)
        if lines[i][j] == "@"
            # count neighbors
            neighbors = Tuple{Int,Int}[]
            for di in (-1, 0, 1), dj in (-1, 0, 1)
                if di != 0 || dj != 0
                    ni = i + di
                    nj = j + dj
                    if 1 <= ni <= H && 1 <= nj <= W && lines[ni][nj] == "@"
                        push!(neighbors, (ni, nj))
                    end
                end
            end
            if length(neighbors) < 4
                counter += 1
                lines[i][j] = "x"
                append!(indices_to_check, neighbors)
            end
        end
    end

    return counter
end

# # get outputs
println("Day 4 - Part 1: $(day04_part1())")
println("Day 4 - Part 2: $(day04_part2())")