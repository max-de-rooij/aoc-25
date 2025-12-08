mutable struct DistanceStack{T}
    distances::Vector{T}
    boxes::Vector{Tuple{Int, Int}}
    size::Int
    min_distance::Int
end

function Base.insert!(stack::DistanceStack{T}, distance::T, boxes::Tuple{Int,Int}) where T
    if distance > stack.min_distance
        location = findfirst(>(distance), stack.distances)
        # check if there is room
        if length(stack.distances) < stack.size
            if isnothing(location)
                push!(stack.distances, distance)
                push!(stack.boxes, boxes)
            else
                insert!(stack.distances, location, distance)
                insert!(stack.boxes, location, boxes)
            end
        else
            if !isnothing(location)
                insert!(stack.distances, location, distance)
                insert!(stack.boxes, location, boxes)
                
                # remove the final one
                deleteat!(stack.distances, stack.size+1)
                deleteat!(stack.boxes, stack.size+1)
            end
        end
    end
end

function Base.popfirst!(stack::DistanceStack{T}) where T
    dist = popfirst!(stack.distances)
    boxes = popfirst!(stack.boxes)
    return boxes, dist
end

function Base.isempty(stack::DistanceStack{T}) where T
    return isempty(stack.distances)
end

function day08_part1(input_file="day08/inputs/day08.txt"; stack_size=10) 
    answer = open(input_file) do io

        # get boxes
        lines = Vector{Int}[]
        foreach(readlines(io)) do line
            push!(lines, parse.(Int, split(line,",")))
        end
        
        # fill stack
        stack = DistanceStack(Int[], Tuple{Int,Int}[], stack_size, 0)
        for i in eachindex(lines), j in i:lastindex(lines)
            if i != j
                distance = sum(abs2, lines[i] - lines[j])
                insert!(stack, distance, (i,j))
            end
        end

        # connect boxes
        circuits = Vector{Int}[[i] for i in 1:length(lines)]

        while !isempty(stack.boxes)
            (box_a, box_b), dist = popfirst!(stack)

            # join the circuit containing box_a and the one containing box_b
            box_a_circuit = popat!(circuits, findfirst(x -> box_a in x, circuits))
            if !(box_b in box_a_circuit)
                # not already connected
                box_b_circuit = popat!(circuits, findfirst(x -> box_b in x, circuits))

                # connect and add
                new_circuit = [box_a_circuit; box_b_circuit]
                push!(circuits, new_circuit)
            else
                push!(circuits, box_a_circuit)
            end
        end

        # sort circuits by length
        prod(length.(sort(circuits, by=length, rev=true))[1:3])
    end
    return answer
end

function day08_part2(input_file="day08/inputs/day08.txt"; stack_size=10) 
    answer = open(input_file) do io

        # get boxes
        lines = Vector{Int}[]
        foreach(readlines(io)) do line
            push!(lines, parse.(Int, split(line,",")))
        end

        min_distance = 0
        circuits = Vector{Int}[[i] for i in 1:length(lines)]

        # fill stack
        stack = DistanceStack(Int[], Tuple{Int,Int}[], stack_size, min_distance)
        for i in eachindex(lines), j in i:lastindex(lines)
            if i != j
                distance = sum(abs2, lines[i] - lines[j])
                insert!(stack, distance, (i,j))
            end
        end

        x_a = 0; x_b = 0

        while length(circuits) > 1
            (box_a, box_b), dist = popfirst!(stack)

            # join the circuit containing box_a and the one containing box_b
            box_a_circuit = popat!(circuits, findfirst(x -> box_a in x, circuits))
            if !(box_b in box_a_circuit)
                # not already connected
                box_b_circuit = popat!(circuits, findfirst(x -> box_b in x, circuits))

                # connect and add
                x_a = lines[box_a][1]; x_b = lines[box_b][1]
                new_circuit = [box_a_circuit; box_b_circuit]
                push!(circuits, new_circuit)
            else
                push!(circuits, box_a_circuit)
            end

            if isempty(stack)
                stack.min_distance = dist
                for i in eachindex(lines), j in i:lastindex(lines)
                    if i != j
                        distance = sum(abs2, lines[i] - lines[j])
                        insert!(stack, distance, (i,j))
                    end
                end
            end
        end
        return x_a * x_b
    end
    return answer
end

println("Day 8 - Part 1: $(day08_part1(stack_size=1000))")
println("Day 8 - Part 2: $(day08_part2(stack_size=5000))")