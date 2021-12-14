module Day13

    using LinearAlgebra

    function parse_input(input::String)

       dots, folds = split(input, "\n\n") 

       dot_idx = map(x -> CartesianIndex(parse(Int, x[1]) + 1, parse(Int, x[2]) + 1), map(x -> split(x, ","), split(dots, "\n")))
       folds = map(x -> [findfirst(y -> y == x[1], ["y", "x"]), parse(Int, x[2])], map(x -> split(split(x, " ")[end], "="), split(folds, "\n")))


       size = maximum(dot_idx)
       paper = zeros(Bool, size[1], size[2])
       paper[dot_idx] .= 1

       return paper', folds
    end

    function fold(fold, A)
        A_1 = selectdim(A, fold[1], 1:fold[2])
        A_2 = selectdim(A, fold[1], size(A, fold[1]):-1:fold[2]+2)
        paper = (A_1.==1) .| (A_2.==1)
        return paper
    end

    function part1(input::String)
        paper, folds = parse_input(input)

        for f in folds[1:1]
            paper = fold(f, paper)
        end
        return sum(paper)
    end

    function part2(input::String)
        paper, folds = parse_input(input)
        for f in folds
            paper = fold(f, paper)
        end

        display(paper)
    end

end