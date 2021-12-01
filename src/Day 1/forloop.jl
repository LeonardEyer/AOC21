module forLoop
    export count_increasing
    
    """
        count_increasing(x)

    Count the number of times a value in x increases from the previous value 

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
end