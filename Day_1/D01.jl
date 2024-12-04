cd(@__DIR__)


function parse_input(path::String)
    lines = readlines(path)
    col_1 = [parse(Int,split(line, "   ")[1]) for line in lines]
    col_2 = [parse(Int,split(line, "   ")[2]) for line in lines]

    return col_1,col_2
end

function part1(col_1::Vector{Int64},col_2::Vector{Int64})
    col_1_sorted = sort(col_1)
    col_2_sorted = sort(col_2)

    total = 0

    for n in 1:length(col_1)
        total += abs(col_1_sorted[n] - col_2_sorted[n])
    end
    return total
end

function part2(col_1::Vector{Int64},col_2::Vector{Int64})

    total = 0

    for n in 1:length(col_1)
        occurances = count(x -> x == col_1[n], col_2)

        total += occurances*col_1[n]
    end
    return total
end

col_1,col_2 = parse_input("input.txt")

println(part1(col_1,col_2))
println(part2(col_1,col_2))