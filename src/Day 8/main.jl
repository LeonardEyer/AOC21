module Day8
    function parse_input(input)
        return map(x -> map(x -> split(x, " "), split(x, " | ")), map(strip, split(input, "\n")))
    end
    function part1(input)
        input = parse_input(input)
        return sum(map(i -> length(filter(x -> length(x) in [2, 3, 4, 7], i[2])), input))
    end

    function part2(input)
        input = parse_input(input)

    end
end