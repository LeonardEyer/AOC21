module Day14
    using DataStructures

    function parse_input(input::String)
        template, insertion = split(input, "\n\n")

        insertions = map(x -> split(x, " -> "), split(insertion, "\n"))
        insertions = map(x -> [x[1], "$(x[1][1])$(x[2])$(x[1][2])"], insertions)

        return template, insertions
    end

    function generate_replacement(pair, insertions)
        insertion = filter(x -> x[1] == pair, insertions)[1]
        if insertion !== nothing
            return replace(pair, (insertion[1] => insertion[2]))
        else
            println("oo")
        end
    end

    function part1(input::String)
        template, insertions = parse_input(input)

        polymer = template
        for step = 1:10
            new_polymer = ""
            for (i, x) in enumerate(polymer[1:end-1])
                pair = polymer[i:i+1]
                if i+1 == length(polymer)
                    new_polymer *= generate_replacement(pair, insertions)
                else
                    new_polymer *= generate_replacement(pair, insertions)[1:end-1]
                end
                
            end
            polymer = new_polymer
        end
        counts = counter(polymer)

        return findmax(counts)[1] - findmin(counts)[1]
        
    end

    function part2(input::String)
        template, insertions = parse_input(input)

    end
end