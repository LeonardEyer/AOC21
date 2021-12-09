module Day9

    using PyPlot

    function parse_input(input)
        return reduce(hcat, map(x -> map(y -> parse(Int, y), collect(x)), split(input, "\n")))'
    end

    function part1(input)
        # Matrix representation
        A = parse_input(input)

        # Generate CartesianIndices
        R = CartesianIndices(A)

        # Find the upper and lower bounds of the indices
        Ifirst, Ilast = first(R), last(R)

        # This will be used to look 1 unit around our current value
        I1 = oneunit(Ifirst)

        # This is were we accumulate risk values
        risk_level_sum = 0
        for I in R
            # Define a window (respecting the boundary)
            window = (max(Ifirst, I-I1):min(Ilast, I+I1))

            # Find all values that are smaller than the current one within the window
            values_smaller = A[I] .< A[window]

            # If all values are smaller then we can log the risk level
            if ((sum(values_smaller) + 1) / length(window)) == 1.0
                risk_level = A[I] + 1
                risk_level_sum += risk_level
            end
        end
        return risk_level_sum
    end



    function find_new_basins(start, window, A)

        explored = []
        exploring_queue = [start]

        I = start
        while !isempty(exploring_queue)
            I = pop!(exploring_queue)
            window = (max(Ifirst, I-I1):min(Ilast, I+I1))
            for p in window
                if (p < 9) && ! (p in explored)
                    push!(exploring_queue, p)
                end
            end
            push!(explored, p)
        end
    end

    function make_cross_window(index, bounds)
        cross = [CartesianIndex(1, 0) CartesianIndex(0, 1) CartesianIndex(-1, 0) CartesianIndex(0 ,-1)]
        pos = [index + x for x in cross]
        return filter(x -> all(Tuple(bounds[1]) .<= Tuple(x) .<= Tuple(bounds[2])), pos)
    end

    function part2(input)
        # Matrix representation
        A = parse_input(input)

        # Generate CartesianIndices
        R = CartesianIndices(A)

        # Find the upper and lower bounds of the indices
        Ifirst, Ilast = first(R), last(R)

        # This will be used to look 1 unit around our current value
        I1 = oneunit(Ifirst)

        basin_sizes = []

        # This is were we accumulate risk values
        for I in R
            # Define a window (respecting the boundary)
            window = (max(Ifirst, I-I1):min(Ilast, I+I1))

            # Find all values that are smaller than the current one within the window
            values_smaller = A[I] .< A[window]

            # If all values are smaller then we can ....
            if ((sum(values_smaller) + 1) / length(window)) == 1.0
                explored = CartesianIndex[]
                exploring_queue = CartesianIndex[I]

                while !isempty(exploring_queue)
                    I = pop!(exploring_queue)
                    window = make_cross_window(I, [Ifirst, Ilast])
                    #display(window)
                    for p in window
                        if (A[p] .< 9) && ! (p in explored) && ! (p in exploring_queue)
                            push!(exploring_queue, p)
                        end
                    end
                    push!(explored, I)
                end
                push!(basin_sizes, length(explored))
            end
        end
        
        return reduce(*, last(sort(basin_sizes), 3))
    end
end
