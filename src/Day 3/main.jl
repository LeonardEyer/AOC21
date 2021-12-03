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
    function part1(input)
        # https://discourse.julialang.org/t/parse-an-array-of-bits-bitarray-to-an-integer/42361
        function bitarr_to_int(arr)
            return sum(arr .* (2 .^ collect(length(arr)-1:-1:0)))
        end
        
        s = binary_to_matrix(input)
        a = mean(s, dims=2) .> 0.5
        b = 1 .- a
        a = bitarr_to_int(a)
        b = bitarr_to_int(b)
        
        return a * b
    end
    function part2(input)
        return 0
    end
end