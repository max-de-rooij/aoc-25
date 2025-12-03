function batteries(input_lines)
    [parse.(Int, split(input_line, "")) for input_line in input_lines]
end

function joltage(batts)
    d_1_i = argmax(batts[1:end-1])
    d_2 = maximum(batts[d_1_i+1:end])
    return batts[d_1_i]*10 + d_2
end

function joltage(batts, n)
    n -= 1
    idxs = [argmax(batts[1:end-n])]
    batt = batts[idxs[end]] * 10^n
    while n > 0
        n -= 1
        d_i_prev = idxs[end]
        push!(idxs, d_i_prev + argmax(batts[d_i_prev+1:end-n]))
        batt += batts[idxs[end]] * 10^n
    end
    return batt
end

function day03_part1(input_file="day03/inputs/day03.txt") 
    open(input_file) do io
    batts = readlines(io) |> batteries
    sum(joltage, batts)
    end
end

function day03_part2(input_file="day03/inputs/day03.txt") 
        open(input_file) do io
    batts = readlines(io) |> batteries
    sum(Base.Fix2(joltage, 12), batts)
    end
end


# get outputs
println("Day 3 - Part 1: $(day03_part1())")
println("Day 3 - Part 2: $(day03_part2())")