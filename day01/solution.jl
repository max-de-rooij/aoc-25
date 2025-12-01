function parse_line(s::String)
    sign = s[1] == 'L' ? -1 : 1
    return sign*parse(Int, s[2:end])
end

function day01_part1(input_file="day01/inputs/day01.txt") 
    open(input_file) do io
        sum(iszero, accumulate(map(parse_line, readlines(io)), init=50) do a,b
            mod(a+b, 100)
        end)
    end
end

function day01_part2(input_file="day01/inputs/day01.txt") 
    open(input_file) do io
        function zero_crossings(a,b)
            crossings = mod(a[1]+b, 100) == 0 ? 1 : 0
            check = a[1] + b
            if check < 0
                crossings += abs(a[1]+b) ÷ 100 + Int(a[1] != 0) - crossings
            elseif check > 100
                crossings += abs(a[1]+b) ÷ 100 - crossings
            end
            return mod(a[1]+b, 100), a[1]+b, crossings
        end
        sum(x -> x[3], accumulate(map(parse_line, readlines(io)), init=(50, 50, 0)) do a,b
            zero_crossings(a,b)
        end)
    end
end

# get outputs
println("Day 1 - Part 1: $(day01_part1())")
println("Day 1 - Part 2: $(day01_part2())")
