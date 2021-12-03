module Day2
    function part1(input)

        function split_parse(x)
            a, b = split(x, " ")
            return [a, parse(Int, b)]
        end

        function sum_second(prev, x)
            return prev + x[2]
        end

        split_input = map(split_parse, input)

        forward = reduce(sum_second, filter(x -> x[1] == "forward", split_input), init=0)
        up = reduce(sum_second, filter(x -> x[1] == "up", split_input), init=0)
        down = reduce(sum_second, filter(x -> x[1] == "down", split_input), init=0)

        return forward * (down - up)
    end
    function part2(input)
        return 0
    end
end

