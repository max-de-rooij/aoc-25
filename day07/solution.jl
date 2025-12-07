function day07_part1(input_file="day07/inputs/day07.txt") 
    open(input_file) do io
        line = readline(io)
        W = length(line)
        # find the S
        beams = findall('S', line)
        splits = 0
        foreach(readlines(io)) do line
            # look at all beam indices
            new_beams = eltype(beams)[]
            for beam in beams
                if line[beam] == '^'  
                    splits += 1                  
                    # bounds check
                    if beam < W && !(beam+1 ∈ new_beams)
                        push!(new_beams, beam+1)
                    end

                    if beam > 1 && !(beam-1 ∈ new_beams)
                        push!(new_beams, beam-1)
                    end
                elseif !(beam ∈ new_beams)
                    push!(new_beams, beam)
                end
            end
            beams = new_beams
        end
        splits
    end
end

function day07_part2(input_file="day07/inputs/day07.txt") 
    open(input_file) do io
        line = readline(io)
        W = length(line)
        # find the S
        timelines = Dict([i => 0 for i in 1:W])
        timelines[findfirst('S', line)] = 1
        foreach(readlines(io)) do line

            positions = findall(x -> timelines[x] > 0, 1:W)
            # look at all beam indices
            for pos in positions
                if line[pos] == '^'
                    current_timelines = timelines[pos]
                  
                    # bounds check
                    if pos < W
                        timelines[pos+1] += current_timelines
                    end

                    if pos > 1
                        timelines[pos-1] += current_timelines
                    end
                    timelines[pos] = 0  
                end
            end
        end
        sum(values(timelines))
    end
end

println("Day 7 - Part 1: $(day07_part1())")
println("Day 7 - Part 2: $(day07_part2())")