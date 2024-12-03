cd(@__DIR__)

function part_1(input::String)
    matches = [ match.captures for match in eachmatch(r"mul\((\d+),(\d+)\)",input)]
    products = [ parse(Int,match[1]) * parse(Int,match[2]) for match in matches]  
    return sum(products)
end

function find_nearest_larger(vector_a, sorted_b)
    nearest_larger = []
    for val in vector_a
        idx = searchsortedfirst(sorted_b, val)
        if idx <= length(sorted_b)
            push!(nearest_larger, sorted_b[idx])
        end
    end
    return nearest_larger
end

function part_2(input::String)

    disable = [seq[2] for seq in  findall(r"don't\(\)",input)]
    region_begin = vcat([1],[seq[2] for seq in  findall(r"do\(\)",input)])
    
    region_end = vcat(find_nearest_larger(region_begin,sort(disable)),[length(input)])
    ranges = [start:ending for (start, ending) in zip(region_begin, region_end)]

    duplicates = []
    previous = region_end[1]
    for i in 2:length(region_end)
        if region_end[i] == previous
            push!(duplicates,i)
        end
        previous = region_end[i]
    end

    deleteat!(ranges,duplicates)

    total = 0
    for range in ranges
        total += part_1(input[range])
    end
    return total
end

input = read("input.txt",String)

println(part_1(input))
println(part_2(input))