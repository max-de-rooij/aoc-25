struct ClosedInterval
    start::Int
    stop::Int
end

@inline function Base.in(x::T, int::ClosedInterval) where T<:Real
    return int.start <= x <= int.stop
end

@inline function Base.length(int::ClosedInterval)
    return int.stop - int.start + 1
end

@inline function overlaps(a::ClosedInterval, b::ClosedInterval)
    (a.stop >= b.start && a.start <= b.start) || (b.stop >= a.start && b.start <= a.start)
end

function combine(a::ClosedInterval, b::ClosedInterval)
    overlaps(a,b) || error("a and b do not overlap")
    ClosedInterval(min(a.start, b.start), max(a.stop, b.stop))
end

function day05_part1(input_file="day05/inputs/day05.txt") 
    intervals, products = open(input_file) do io
        lines = readlines(io)
        intervals = ClosedInterval[]
        # read intervals
        i = 1
        while !isempty(lines[i])
            start, stop = split(lines[i], "-")
            push!(intervals, ClosedInterval(parse(Int, start), parse(Int, stop)))
            i += 1
        end
        products = Int[]
        for line in lines[i+1:end]
            push!(products, parse(Int, line))
        end
        
        intervals,products
    end

    sum(x -> any(in.(x, intervals)), products)

end 

function day05_part2(input_file="day05/inputs/day05.txt")
    # read my intervals 
    intervals = open(input_file) do io
        lines = readlines(io)
        intervals = ClosedInterval[]
        # read intervals
        i = 1
        while !isempty(lines[i])
            start, stop = split(lines[i], "-")
            push!(intervals, ClosedInterval(parse(Int, start), parse(Int, stop)))
            i += 1
        end
        intervals
    end

    new_intervals = ClosedInterval[]
    current_length = length(intervals)
    while current_length != length(new_intervals)
        current_length = length(intervals)

        intermediate_intervals = copy(intervals)
        new_intervals = ClosedInterval[]
        while !isempty(intermediate_intervals)
            current_interval = pop!(intermediate_intervals)
            
            i = 1
            while i <= length(intermediate_intervals)
                int = popfirst!(intermediate_intervals)
                if overlaps(current_interval, int)
                    current_interval = combine(current_interval, int)
                else
                    push!(intermediate_intervals, int)
                end
                i += 1
            end
            push!(new_intervals, current_interval)
        end
        intervals = copy(new_intervals)
    end

    sum(length, intervals)
end

println("Day 5 - Part 1: $(day05_part1())")
println("Day 5 - Part 2: $(day05_part2())")