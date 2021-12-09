module Day9

    function parse_input(input)
        return reduce(hcat, map(x -> map(y -> parse(Int, y), collect(x)), split(input, "\n")))'
    end

    function part1(input)
        A = parse_input(input)

        R = CartesianIndices(A)
        Ifirst, Ilast = first(R), last(R)
        I1 = oneunit(Ifirst)

        out = 0
        for I in R
            window = (max(Ifirst, I-I1):min(Ilast, I+I1))
            if (sum(A[I] .< A[window]) + 1) / length(window) == 1.0
                risk_level = A[I] + 1
                out += risk_level
            end
        end
        return out
    end

    function part2(input)
        input = parse_input(input)
    end
end
