cd(@__DIR__)

function parse_input(path::String)
    input = readlines(path) |> lines ->
        [collect(line) for line in lines] |> arrays ->
        hcat(arrays...)
    return permutedims(input)
end



input = parse_input("input.txt")

input[CartesianIndex(1,2)]

checkbounds(Bool,input,CartesianIndex(140,140))

function safe_lookup(coords::CartesianIndex, input::Matrix{Char})
    if checkbounds(Bool,input,coords)
        return input[coords]
    else
        return NaN
    end
end

function count_words_pt1(coords::CartesianIndex)
    directions = [[safe_lookup(x,input) for x in coords.+ [CartesianIndex(1,0),CartesianIndex(2,0),CartesianIndex(3,0)]],
    [safe_lookup(x,input) for x in coords .+ [CartesianIndex(1,-1),CartesianIndex(2,-2),CartesianIndex(3,-3)]],
    [safe_lookup(x,input) for x in coords .+ [CartesianIndex(0,-1),CartesianIndex(0,-2),CartesianIndex(0,-3)]],
    [safe_lookup(x,input) for x in coords .+ [CartesianIndex(-1,-1),CartesianIndex(-2,-2),CartesianIndex(-3,-3)]],
    [safe_lookup(x,input) for x in coords .+ [CartesianIndex(-1,0),CartesianIndex(-2,0),CartesianIndex(-3,0)]],
    [safe_lookup(x,input) for x in coords .+ [CartesianIndex(-1,1),CartesianIndex(-2,2),CartesianIndex(-3,3)]],
    [safe_lookup(x,input) for x in coords .+ [CartesianIndex(0,1),CartesianIndex(0,2),CartesianIndex(0,3)]],
    [safe_lookup(x,input) for x in coords .+ [CartesianIndex(1,1),CartesianIndex(2,2),CartesianIndex(3,3)]]]
    words = count(x -> x == ['M','A','S'], directions)
    return words
end

function part_1(input::Matrix{Char})
    total_words = 0
    for coords in CartesianIndices(input)
        if input[coords] == 'X'
            total_words += count_words_pt1(coords)
        end
    end
    return total_words
end

function count_words_pt2(coords::CartesianIndex)
    directions = [[safe_lookup(x,input) for x in coords.+ [CartesianIndex(-1,-1),CartesianIndex(0,0),CartesianIndex(1,1)]],
    [safe_lookup(x,input) for x in coords .+ [CartesianIndex(1,1),CartesianIndex(0,0),CartesianIndex(-1,-1)]],
    [safe_lookup(x,input) for x in coords .+ [CartesianIndex(-1,1),CartesianIndex(0,0),CartesianIndex(1,-1)]],
    [safe_lookup(x,input) for x in coords .+ [CartesianIndex(1,-1),CartesianIndex(0,0),CartesianIndex(-1,1)]]]
    words = count(x -> x == ['M','A','S'], directions)
    return words == 2 ? 1 : 0
end

function part_2(input::Matrix{Char})
    total_words = 0
    for coords in CartesianIndices(input)
        if input[coords] == 'A'
            total_words += count_words_pt2(coords)
        end
    end
    return total_words
end

println(part_1(input))
println(part_2(input))