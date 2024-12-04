cd(@__DIR__)

function parse_input(path::String)
    lines = readlines(path)
    data = [parse.(Int, split(line, r"\s+")) for line in lines]
    return data
end

function part_1(reports::Vector{Vector{Int64}})
    n_pass = 0
    for report in reports
       diffs = diff(report) 
       if (all(diffs .> 0) || all(diffs .< 0)) && maximum(abs.(diffs)) < 4
            n_pass +=1
       end
    end
    return n_pass
end

function part_2(vectors::Vector{Vector{Int}})
    function check_vector_with_drop(vec::Vector{Int})
        diffs = diff(vec)
        positive_count = count(>(0), diffs)  
        negative_count = count(<(0), diffs) 
        predominant_direction = if positive_count >= negative_count
            x -> x > 0 
        else
            x -> x < 0 
        end
        
        if valid_vector(vec)
            return true
        end

        invalid_indices = findall(x -> 0 == x || abs(x) > 3 || !predominant_direction(x), diffs)

        invalid_idx = invalid_indices[1]

        left_candidate = invalid_idx
        right_candidate = invalid_idx + 1

        if valid_vector(vcat(vec[1:left_candidate-1], vec[left_candidate+1:end])) ||
           valid_vector(vcat(vec[1:right_candidate-1], vec[right_candidate+1:end]))
            return true
        end

        return false
    end

    function valid_vector(vec)
        diffs = diff(vec)
        abs_diffs = abs.(diffs)
        all(abs_diffs .<= 3) && ((all(diffs .> 0) || all(diffs .< 0)))
    end

    return count(check_vector_with_drop, vectors)
end



input = parse_input("input.txt")

println(part_1(input))
println(part_2(input))