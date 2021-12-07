module Day7
    using Statistics
    function parse_input(input)
        return sort(map(x -> parse(Int, x), split(input, ",")))
    end

    function part1(input)
        positions = parse_input(input)
        return Int(sum(abs.(positions .- median(positions))))

    end
    function part2(input)
        
    end
end