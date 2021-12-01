module forLoop

    export count_increasing
    
    function count_increasing(input)
        counter = -1
        last = 0
        for x in input
            if x > last 
                counter += 1
            end
            last = x
        end
        return counter
    end

end
