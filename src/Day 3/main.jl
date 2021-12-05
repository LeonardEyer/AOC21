module Day3
    using Statistics

    function binary_to_matrix(x)
        function parse_binary(x)
            return map(x -> parse(Int, x), collect(x))
        end
        binary = collect(Iterators.flatten(map(parse_binary, x)))
        matrix = reshape(binary, length(x[1]), length(x))

        return matrix
    end

    # https://discourse.julialang.org/t/parse-an-array-of-bits-bitarray-to-an-integer/42361
    function bitarr_to_int(arr)
        return sum(arr .* (2 .^ collect(length(arr)-1:-1:0)))
    end

    function part1(input)
        s = binary_to_matrix(input)
        a = mean(s, dims=2) .> 0.5
        b = 1 .- a
        a = bitarr_to_int(a)
        b = bitarr_to_int(b)
        
        return a * b
    end

    function bitarr_to_index(a)
        result = Int[]
        for (index, value) in enumerate(a)
            if value
                push!(result, index)
            end
        end
        return result
    end

    function seivewithcond(cond, s)
        # Iterate over all bits
        for i = 1:size(s, 1)
            if size(s, 2) == 1
                break
            end
            a = cond(s)
            idx = s[i,:] .!= a[i]
            s = s[:, setdiff(1:end, bitarr_to_index(idx))]
        end

        return s
    end


    function part2(input)
        function maskop(op, arr, mask; dims=[])
            return mapslices(op, arr, dims=dims)
        end
        # Matrix representation of input
        s = binary_to_matrix(input)

        # Allocate output
        a = seivewithcond((x) -> mean(x, dims=2) .>= 0.5, s)
        b = seivewithcond((x) -> mean(x, dims=2) .< 0.5, s)

        return bitarr_to_int(a) * bitarr_to_int(b)
    end
end