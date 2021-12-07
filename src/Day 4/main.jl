module Day4

    using LinearAlgebra

    struct BingoBoard
        board :: Matrix
        markers :: BitMatrix
    end

    function display(board::BingoBoard)
        display(board.board)
        display(board.markers)
    end

    function has_won(board::BingoBoard)
        horizontal = mapslices(sum, board.markers, dims = [1])[:]
        vertical = mapslices(sum, board.markers, dims = [2])[:]
        diagonals = [tr(board.markers), tr(transpose(board.markers))]

        winning = reduce(vcat, [horizontal, vertical, diagonals])
        return any(winning .>= 5)
    end

    function mark!(board::BingoBoard, value::Int)
        for i in findall(x -> x == value, board.board)
            board.markers[i] = true
        end
    end

    function sum_all_unmarked(board::BingoBoard)
        sum = 0
        for i in findall(x -> x == false, board.markers)
            sum += board.board[i]
        end
        return sum
    end

    function string_to_bingo(x)
        function parse_int_vector(x)
            return map(x -> parse(Int, x), split(x))
        end
        ints = collect(Iterators.flatten(map(parse_int_vector, x)))
        bingo = transpose(reshape(ints, 5, 5))

        return bingo
    end

    function parse_input(input)
        input = map(strip, split(input, "\n"))
        a = filter(x -> length(x) > 0, input)
        draworder = map(x -> parse(Int, x), split(a[1], ","))
        boards = a[2:end]

        board_structs = BingoBoard[]
        for i = 1:5:length(boards)-4
            matrix = string_to_bingo(boards[i:i+4])
            board = BingoBoard(matrix, falses(size(matrix)))

            push!(board_structs, board)
        end

        return draworder, board_structs
    end

    function part1(input)
        order, boards = parse_input(input)

        for v in order
            for b in boards
                mark!(b, v)
                if has_won(b)
                    return v * sum_all_unmarked(b)
                end
            end
        end

    end

    function part2(input)
        order, boards = parse_input(input)

        for v in order
            map(x -> mark!(x, v), boards)
            for (i, b) in enumerate(boards)
                if has_won(b) 
                    if length(boards) == 1
                        return v * sum_all_unmarked(b)
                    end
                    deleteat!(boards, i)
                end
            end
        end
    end
end