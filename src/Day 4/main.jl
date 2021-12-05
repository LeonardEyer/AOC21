module Day4

    function string_to_bingo(x)
        function parse_int_vector(x)
            return map(x -> parse(Int, x), split(x))
        end
        ints = collect(Iterators.flatten(map(parse_int_vector, x)))
        bingo = reshape(ints, 5, 5)

        return bingo
    end
    function parse_input(input)
        a = filter(x -> length(x) > 0, split(input, "\n"))
        draworder = map(x -> parse(Int, x), split(a[1], ","))
        boards = a[2:end]

        board_matrices = []
        for i = 1:length(boards)-4
            matrix = string_to_bingo(boards[i:i+4])
            push!(board_matrices, matrix)
        end

        return draworder, boards
    end

    function part1(input)
        order, boards = parse_input(input)
    end

    function part2(input)
        order, boards = parse_input(input)
    end
end