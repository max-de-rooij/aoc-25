function span_rectangle(tile_a, tile_b)
    top_left = [min(tile_a[1], tile_b[1]), min(tile_a[2], tile_b[2])]
    bottom_left = [min(tile_a[1], tile_b[1]), max(tile_a[2], tile_b[2])]
    top_right = [max(tile_a[1], tile_b[1]), min(tile_a[2], tile_b[2])]
    bottom_right = [max(tile_a[1], tile_b[1]), max(tile_a[2], tile_b[2])]

    return top_left, bottom_left, bottom_right, top_right
end

function intersects(c, low, high, lines)

    return any(l -> (l[2] <= c <= l[3]) && (low < l[1] < high), lines)

end

function rect_in_area(tile_a, tile_b, horizontal_lines, vertical_lines)

    top_left, bottom_left, bottom_right, top_right = span_rectangle(tile_a, tile_b)
    vertical_below = [line for line in vertical_lines if line[3] > top_left[2]]
    check_top = intersects(top_left[2], top_left[1], top_right[1], vertical_below)

    vertical_above = [line for line in vertical_lines if line[2] < bottom_left[2]]
    check_bottom = intersects(bottom_left[2], bottom_left[1], bottom_right[1], vertical_above)


    horizontal_right = [line for line in horizontal_lines if line[3] > top_left[1]]
    check_left = intersects(top_left[1], top_left[2], bottom_left[2], horizontal_right)
    horizontal_left = [line for line in horizontal_lines if line[2] < top_right[1]]
    check_right = intersects(top_right[1], top_right[2], bottom_right[2], horizontal_left)

    !any([check_top, check_bottom, check_left, check_right])
end

function day09_part1(input_file="day09/inputs/day09.txt") 
    tiles = open(input_file) do io
        [parse.(Int, split(line, ',')) for line in readlines(io)]
    end

    maximum_area = 0
    for i in eachindex(tiles)
        for j in i:lastindex(tiles)
            area = prod(abs, tiles[i]-tiles[j] .+ 1)
            if area > maximum_area
                maximum_area = area
            end
        end
    end

    maximum_area
end

function day09_part2(input_file="day09/inputs/day09.txt") 
    tiles = open(input_file) do io
        [parse.(Int, split(line, ',')) for line in readlines(io)]
    end

    vertical = []; horizontal = []
    for (i, (dh, dv)) in enumerate(diff(tiles))
        if dv != 0
            start = min(tiles[i][2], tiles[i+1][2]); stop = max(tiles[i][2], tiles[i+1][2])
            push!(vertical, [tiles[i][1], start, stop])
        else
            start = min(tiles[i][1], tiles[i+1][1]); stop = max(tiles[i][1], tiles[i+1][1])
            push!(horizontal, [tiles[i][2], start, stop])
        end
    end

    # add last diff between tiles[1] and tiles[end]
    dh,dv = tiles[1] .- tiles[end]
    if dv != 0
        start = min(tiles[1][2], tiles[end][2]); stop = max(tiles[1][2], tiles[end][2])
        push!(vertical, [tiles[1][1], start, stop])
    else
        start = min(tiles[1][1], tiles[end][1]); stop = max(tiles[1][1], tiles[end][1])
        push!(horizontal, [tiles[1][2], start, stop])
    end

    maximum_area = 0;
    for i in eachindex(tiles)
        for j in i:lastindex(tiles)
            area = prod(abs.(tiles[i]-tiles[j]) .+ 1)
            if area > maximum_area && rect_in_area(tiles[i], tiles[j], horizontal, vertical)
                maximum_area = area
            end
        end
    end
    maximum_area
end


println("Day 9 - Part 1: $(day09_part1())")
println("Day 9 - Part 2: $(day09_part2())")