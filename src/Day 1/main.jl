module Day1
    export count_increasing
    export count_three_sum_increasing
    
    """
        count_increasing(x)

    Count the number of times a value in x increases from the previous value using a for loop

    # Examples
    ```julia-repl
    julia> count_increasing([1, 2, 2, 4])
    2
    ```
    """ 
    function count_increasing(input)
        # Initialize counter and first value to compare
        counter = -1
        last = 0
        for x in input
            # Everytime we have an increase increment
            if x > last 
                counter += 1
            end
            # Remember the last seen value
            last = x
        end
        return counter
    end

    function three_sum(input)
        new_input = []
        for x in 1:length(input)-2
            push!(new_input, input[x] + input[x + 1] + input[x + 2])
        end
        return new_input
    end

    function count_three_sum_increasing(input)
        return count_increasing(three_sum(input))  
    end
end