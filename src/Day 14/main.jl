module Day14
    function parse_input(input::String)
        template, insertion = split(input, "\n\n")

        insertions = map(x -> split(x, " -> "), split(insertion, "\n"))
        insertion_dict = Dict((k, ["$(k[1])$(v)", "$(v)$(k[2])"]) for (k, v) in insertions)

        return template, insertion_dict
    end

    function generate_map(insertions)
        pairs = collect(keys(insertions))
        pair_map = zeros(Bool, (length(insertions), length(insertions)))

        for (i, pair) in enumerate(pairs)
            for p in insertions[pair]
                pair_map[i, pairs .== p] .= 1
            end
        end
        return pair_map
    end

    function generate_template_vector(template, insertions)
        template_vector = zeros(Int, length(insertions))
        pairs = []
        for i = 1:length(template)-1
            push!(pairs, template[i:i+1])
        end
        
        for p in pairs
            id = findfirst(x -> x == p, collect(keys(insertions)))
            template_vector[id] += 1
        end
        return template_vector'
    end

    function run_simulation(n_steps, template, insertions)
        A = generate_map(insertions)
        b = generate_template_vector(template, insertions)
        return b * A^n_steps
    end

    function part1(input::String)
        template, insertions = parse_input(input)
        pairs = collect(keys(insertions))

        result = run_simulation(10, template, insertions)

        count_dict = Dict((k, 0.) for k in collect(Iterators.flatten(pairs)))
        for (i, x) in enumerate(result)
            if x > 0
                for c in collect(pairs[i])
                    count_dict[c] += 0.5 * x
                end
            end
        end

        return ceil(Int, findmax(count_dict)[1]) - ceil(Int, findmin(count_dict)[1])
    end

    function part2(input::String)
        template, insertions = parse_input(input)
        pairs = collect(keys(insertions))

        result = run_simulation(40, template, insertions)

        count_dict = Dict((k, 0.) for k in collect(Iterators.flatten(pairs)))
        for (i, x) in enumerate(result)
            if x > 0
                for c in collect(pairs[i])
                    count_dict[c] += 0.5 * x
                end
            end
        end

        return ceil(Int, findmax(count_dict)[1]) - ceil(Int, findmin(count_dict)[1])
    end
    
end