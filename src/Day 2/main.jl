module Day2

    function split_parse(x)
        a, b = split(x, " ")
        return [a, parse(Int, b)]
    end

    function sum_second(prev, x)
        return prev + x[2]
    end
    
    function part1(input)
        split_input = map(split_parse, input)

        forward = reduce(sum_second, filter(x -> x[1] == "forward", split_input), init=0)
        up = reduce(sum_second, filter(x -> x[1] == "up", split_input), init=0)
        down = reduce(sum_second, filter(x -> x[1] == "down", split_input), init=0)

        return forward * (down - up)
    end

    function part2(input)
        split_input = map(split_parse, input)
        horizontal = 0
        aim = 0
        depth = 0
        for x in split_input
            if x[1] == "forward"
                horizontal += x[2]
                depth += aim * x[2]
            elseif x[1] == "down"
                aim += x[2]
            elseif x[1] == "up"
                aim -= x[2]
            end
        end
        println(horizontal, ", " , depth)
        return horizontal * depth
    end
end