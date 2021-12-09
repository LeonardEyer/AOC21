module Day9

    function parse_input(input)
        return reduce(hcat, map(x -> map(y -> parse(Int, y), collect(x)), split(input, "\n")))'
    end

    function part1(input)
        A = parse_input(input)

        R = CartesianIndices(A)
        Ifirst, Ilast = first(R), last(R)

        # This will be used to look 1 unit around our current value
        I1 = oneunit(Ifirst)

        out = 0
        for I in R
            # Define a window (respecting the boundary)
            window = (max(Ifirst, I-I1):min(Ilast, I+I1))

            # Find all values that are smaller than the current one within the window
            values_smaller = A[I] .< A[window]

            # If all values are smaller then we can log the risk level
            if ((sum(values_smaller) + 1) / length(window)) == 1.0
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
