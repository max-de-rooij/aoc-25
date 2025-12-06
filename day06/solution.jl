function day06_part1(input_file="day06/inputs/day06.txt") 
    lines = open(input_file) do io
        split.(readlines(io))
    end
    total = 0
    for (i,operator) in enumerate(lines[end])
        if operator == "+"
            total += sum(x -> parse(Int, x), [line[i] for line in lines[1:end-1]])
        else
            total += prod(x -> parse(Int, x), [line[i] for line in lines[1:end-1]])
        end
    end
    total

end

function day06_part2(input_file="day06/inputs/day06.txt") 
        lines = open(input_file) do io
        readlines(io)
    end
    operators = split(lines[end])
    total = 0; j = 1
    for operator in operators
        next_problem = false; numbers = Int[]
        while !next_problem
            # read index j of the lines
            if j > length(lines[1])
                digits = " "
            else
                digits = prod(line[j] for line in lines[1:end-1])
            end
            if isempty(strip(digits))
                if operator == "+"
                    total += sum(numbers)
                else
                    total += prod(numbers)
                end
                next_problem = true
            else
                push!(numbers, parse(Int, strip(digits)))
            end
            j += 1
        end
    end
    total
end

println("Day 6 - Part 1: $(day06_part1())")
println("Day 6 - Part 2: $(day06_part2())")