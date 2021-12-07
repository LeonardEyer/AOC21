module Day6
    function parse_input(input)
        fish = map(x -> parse(Int, x), split(input, ","))
        return fish
    end

    function run_epoch(fish)
        fish = fish .- 1   
        mask_new_fish = fish .== -1
        fish[mask_new_fish] .= 6
        new_fish = ones(Int, count(mask_new_fish)) * 8
        return vcat(fish, new_fish)
    end

    function run_epochs(fish, n_epochs)
        return 6 - ((n_epochs) % 7)
    end

    function part1(input)
        fish = parse_input(input)

        n_days = 80

        for i = 1:n_days
            fish = run_epoch(fish)
        end

        return length(fish)
    end

    function part2(input)
        fish = parse_input(input)

        n_days = 256

        for i = 1:n_days
            fish = run_epoch(fish)
        end

        return length(fish)
    end
end