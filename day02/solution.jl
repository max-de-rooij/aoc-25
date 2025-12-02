function read_ranges(io)
    data = readline(io)
    ranges = split(data, ',')
    return [parse.(Int, split(r, '-')) for r in ranges]
end

function repnum(number)
    number * 10^ndigits(number) + number
end

function repnum(number, n)
    d = ndigits(number)
    out = number * 10^d + number
    n -= 2
    init = number
    while n > 0
        out *= 10^d
        out += init
        n -= 1
    end
    return out
end

function invalid_ids(start::Int64, stop::Int64)

    # digit ranges
    digit_range = ndigits(start):ndigits(stop)

    # filter even digit ranges and divide by 2
    digit_range = filter(iseven, digit_range) .÷ 2

    if isempty(digit_range)
        return Int64[]
    end
    # get the first number in the range with digit_range[1]*2 number of digits
    initial_num = (start:stop)[findfirst(x -> ndigits(x) == digit_range[1]*2, start:stop)]

    num = parse(Int, join(reverse(digits(initial_num))[1:digit_range[1]]))

    invalids = Int64[]
    while repnum(num) <= stop
        if repnum(num) >= start
            push!(invalids, repnum(num))
        end
        num += 1
    end

    return invalids
end

function invalid_ids_part2(start::Int64, stop::Int64)

    # get the first number in the range with digit_range[1]*2 number of digits
    num = 1

    invalids = Int64[]
    while repnum(num) <= stop # at least twice repeated

        # get possibilities
        possibilities = 2:(ndigits(stop) ÷ ndigits(num))
        for p in possibilities
            poss = repnum(num, p)
            if (start <= poss <= stop) && !(poss ∈ invalids)
                push!(invalids, poss)
            end
        end

        num += 1
    end
    return invalids
end


function day02_part1(input_file="day02/inputs/day02.txt") 
    ranges = open(input_file) do io
    read_ranges(io)
    end

    sum([sum(invalid_ids(r[1], r[2])) for r in ranges])
end

function day02_part2(input_file="day02/inputs/day02.txt") 
    ranges = open(input_file) do io
    read_ranges(io)
    end

    sum([sum(invalid_ids_part2(r[1], r[2])) for r in ranges])
end

# get outputs
println("Day 2 - Part 1: $(day02_part1())")
println("Day 2 - Part 2: $(day02_part2())")