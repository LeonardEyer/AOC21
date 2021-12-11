module Day11
    function parse_input(input::String)::Matrix{Int64}
        return reduce(hcat, map(x -> map(y -> parse(Int, y), collect(x)), split(input, "\n")))'
    end

    function square_window(index::CartesianIndex, bounds::Tuple{CartesianIndex, CartesianIndex})
        I1 = oneunit(index)
        window = max(bounds[1], index-I1):min(bounds[2], index+I1)
        return window
    end

    function part1(input::String)
        input = parse_input(input)
        steps = 100
        flash_count = 0
        indices = CartesianIndices(input)
        bounds = (first(indices), last(indices))
    
        for i = 1:steps
            input = (input .+ 1)
            flashed = findall(x -> x == 10, input)
            flash_count += length(flashed)
            while !isempty(flashed)
                idx = pop!(flashed)
                window = square_window(idx, bounds)
                input[window] = (input[window] .+ 1)
                flashed_again = setdiff(findall(x -> x == 10, input), flashed)
                flash_count += length(flashed_again)
                flashed = unique(cat(flashed, flashed_again, dims=1))
            end
            input[input .> 9] .= 0
        end

        return flash_count
    end

    function part2(input::String)
        input = parse_input(input)

        indices = CartesianIndices(input)
        bounds = (first(indices), last(indices))
        iteration_count = 0
        while true
            input = (input .+ 1)
            flashed = findall(x -> x == 10, input)
            while !isempty(flashed)
                idx = pop!(flashed)
                window = square_window(idx, bounds)
                input[window] = (input[window] .+ 1)
                flashed_again = setdiff(findall(x -> x == 10, input), flashed)
                flashed = unique(cat(flashed, flashed_again, dims=1))
            end
            input[input .> 9] .= 0
            iteration_count += 1

            if all(input .== 0) 
                return iteration_count
            end
        end
    end

end