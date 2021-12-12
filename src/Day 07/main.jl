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
        positions = parse_input(input)
        counter = zeros(Int, maximum(positions))
        for (i,c) in enumerate(counter)
            offset = abs.(positions .- i)
            fuel_cost = (offset .* (offset .+ 1)) ./ 2
            counter[i] += sum(fuel_cost)
        end
        return minimum(counter)
    end
    
    function part2_quick(input)
        positions = parse_input(input)
        offset = abs.(positions .- floor(Int, mean(positions)))
        fuel_cost = (offset .* (offset .+ 1)) ./ 2
        return round(Int, sum(fuel_cost))
    end
end