function read_rolls(file_name)
    open(file_name) do io
        locs = CartesianIndex{2}[]
        for (row,line) in enumerate(readlines(io))
            cols = findall('@', line)
            append!(locs, [CartesianIndex(row, col) for col in cols])
        end
        locs
    end
end

function neighbors(index::T, indices::Vector{T}) where T<:CartesianIndex{2}
    # return the neighbors of index that are in indices
    Δ = CartesianIndex.([(-1, -1), (-1, 0), (1, 1), (0, -1), (1, 0), (0, 1), (1, -1), (-1, 1)])
    return indices[indices .∈ Ref(index .+ Δ)]
end

function neighborsin(index::T, indices::Vector{T}, n::Int) where T<:CartesianIndex{2}
    Δ = CartesianIndex.([(-1, -1), (-1, 0), (1, 1), (0, -1), (1, 0), (0, 1), (1, -1), (-1, 1)])
    count(i -> i ∈ indices, index .+ Δ) .< n
end

function day04_part1(input_file="day04/inputs/day04.txt") 
    roll_locations = read_rolls(input_file)
    count(l -> neighborsin(l, roll_locations, 4), roll_locations)
end

function day04_part2(input_file="day04/inputs/day04.txt")
    original_roll_locations = read_rolls(input_file)
    n_dropped = 1; total_dropped = 0
    locations_to_check = copy(original_roll_locations)
    while n_dropped > 0
        # which to drop
        drop_ = map(l -> neighborsin(l, original_roll_locations, 4), locations_to_check)
        rolls_to_drop = locations_to_check[drop_]
        # find their neighbors
        new_rolls_to_check = CartesianIndex{2}[]
        for roll in rolls_to_drop
            append!(new_rolls_to_check, neighbors(roll, original_roll_locations))
        end

        # make unique
        new_rolls_to_check = unique(new_rolls_to_check)
        # remove the ones to drop
        new_rolls_to_check = new_rolls_to_check[.!(new_rolls_to_check .∈ Ref(rolls_to_drop))]
        original_roll_locations = copy(original_roll_locations[.!(original_roll_locations .∈ Ref(rolls_to_drop))])
        
        n_dropped = length(rolls_to_drop)
        locations_to_check = new_rolls_to_check
        total_dropped += n_dropped
    end
    total_dropped
end


# get outputs
println("Day 4 - Part 1: $(day04_part1())")
println("Day 4 - Part 2: $(day04_part2())")