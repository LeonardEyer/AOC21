module Day8
    using LinearAlgebra

    segment_digit_map = [
        1 1 1 0 1 1 1;
        0 0 1 0 0 1 0;
        1 0 1 1 1 0 1;
        1 0 1 1 0 1 1;
        0 1 1 1 0 1 0;
        1 1 0 1 0 1 1;
        1 1 0 1 1 1 1;
        1 0 1 0 0 1 0;
        1 1 1 1 1 1 1;
    ]

    test_mix = [
        0 0 1 0 0 0 0;
        0 0 0 0 0 1 0;
        0 0 0 0 0 0 1;
        1 0 0 0 0 0 0;
        0 1 0 0 0 0 0;
        0 0 0 1 0 0 0;
        0 0 0 0 1 0 0;
    ]

    function parse_input(input)
        return map(x -> map(x -> split(x, " "), split(x, " | ")), map(strip, split(input, "\n")))
    end
    function part1(input)
        input = parse_input(input)
        return sum(map(i -> length(filter(x -> length(x) in [2, 3, 4, 7], i[2])), input))
    end

    function part2(input)
        input = parse_input(input)
        display(segment_digit_map)
        mixed = segment_digit_map * test_mix'

        display(test_mix')


        A = segment_digit_map[[1, 4, 7, 8] .+ 1, :]
        b = mixed[[1, 4, 7, 8] .+ 1, :]
        println("A")
        #display(A)
        println("b")
        #display(b)

        #imshow(segment_digit_map)
    end
end