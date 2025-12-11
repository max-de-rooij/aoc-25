function count_paths(graph, source, target)

    # define a cache
    cache = Dict{String, Int}()
    cache[target] = 1

    return dfs(source, graph, cache)
end

function dfs(state, graph, cache)
    # assumption: graph has no cycles
    if state in keys(cache)
        return cache[state]
    else
        count = 0
        if state in keys(graph)
            for edge in graph[state]
                count += dfs(edge, graph, cache)
            end

            cache[state] = count
        end
        return count    
    end
end

function day11_part1(input_file="day11/inputs/day11.txt") 
    open(input_file) do io
        # get the graph
        graph = Dict{String, Vector{String}}()
        foreach(readlines(io)) do line
            source, targets = split(line, ':')
            targets = split(targets)
            graph[source] = targets
        end
        
        # first idea: dfs
        count_paths(graph, "you", "out")
    end
end

function day11_part2(input_file="day11/inputs/day11.txt") 
    open(input_file) do io

        # get the graph
        graph = Dict{String, Vector{String}}()
        foreach(readlines(io)) do line
            source, targets = split(line, ':')
            targets = split(targets)
            graph[source] = targets
        end
        
        # 2 possibilities: 
        #   svr -> dac -> fft -> out
        #   svr -> fft -> dac -> out
        prod([count_paths(graph, "svr", "dac"), count_paths(graph, "dac", "fft"), count_paths(graph, "fft", "out")]) + prod([count_paths(graph, "svr", "fft"), count_paths(graph, "fft", "dac"), count_paths(graph, "dac", "out")])
    end
end

println("Day 11 - Part 1: $(day11_part1())")
println("Day 11 - Part 2: $(day11_part2())")