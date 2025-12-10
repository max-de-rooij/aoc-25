using JuMP, HiGHS # for part 2

struct LightState
    state::BitVector
    cost::Int
end

function press(state::LightState, button)
    LightState(xor.(state.state, button), state.cost + 1)
end

# part 1; bfs
function bfs(root::LightState, buttons, goal)
    queue = [root,]
    explored = [root.state,]
    while !isempty(queue)
        state = popfirst!(queue)
        if state.state == goal
            return state
        else
            for button in buttons
                new_state = press(state, button)
                if !(new_state.state in explored)
                    push!(explored, new_state.state)
                    push!(queue, new_state)
                end
            end
        end
    end
end

function day10_part1(input_file="day10/inputs/day10.txt") 
    return open(input_file) do io
        goal_r = r"\[([\.#]+)\]"
        buttons_r = r"\(([\d,]+)\)"
        result = 0 
        foreach(readlines(io)) do line
            goal = String.(match(goal_r, line).captures)[1]
            goal = parse.(Bool, split(replace(goal, "." => "0", "#" => "1"),""))
            
            button_matches = collect(eachmatch(buttons_r, line))
            buttons = BitVector[]
            for rmatch in eachmatch(buttons_r, line)
                match = rmatch.captures[1]
                button = zeros(Bool, length(goal))
                indices = parse.(Int,split(match, ",")) .+ 1
                button[indices] .= true
                push!(buttons, button)
            end
            
            root = LightState(zeros(Bool, length(goal)), 0)

            trajectory = bfs(root, buttons, goal)
            result += trajectory.cost
        end
        result
    end
end

function day10_part2(input_file="day10/inputs/day10.txt") 
    return open(input_file) do io
        goal_r = r"\{([\d,]+)\}"
        buttons_r = r"\(([\d,]+)\)"
        result = 0 
        foreach(readlines(io)) do line
            goal = parse.(Int, split(String.(match(goal_r, line).captures)[1], ","))      
            button_matches = collect(eachmatch(buttons_r, line))
            buttons = BitVector[]
            for rmatch in eachmatch(buttons_r, line)
                match = rmatch.captures[1]
                button = zeros(Bool, length(goal))
                indices = parse.(Int,split(match, ",")) .+ 1
                button[indices] .= true
                push!(buttons, button)
            end
            
            model = Model(HiGHS.Optimizer)
            set_silent(model)
            n_variables = length(buttons)
            @variable(model, x[1:n_variables] >= 0, Int)
            @objective(model, Min, x)
            # for each outcome add constraints
            for i in eachindex(goal)

                # find where buttons[i] == 1
                c_ind = Int[]
                for (j, b) in enumerate(buttons)
                    if b[i]
                        push!(c_ind, j)
                    end
                end
                
                @constraint(model, sum(x[c_ind]) == goal[i])
            end

            optimize!(model)

            result += objective_value(model)

        end
        Int(result)
    end
end


println("Day 10 - Part 1: $(day10_part1())")
println("Day 10 - Part 2: $(day10_part2())")