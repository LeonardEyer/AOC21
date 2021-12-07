module Day6

    function parse_input(input)
        return map(x -> parse(Int, x), split(input, ","))
    end

    function generate_histogram(fish)
        fish_histogram = zeros(Int, 9)
        for x in fish
            fish_histogram[x + 1] += 1
        end
        return fish_histogram
    end

    function run_epoch_histogram(fish_histogram)
        fish_histogram = circshift(fish_histogram, -1)
        fish_histogram[7] += fish_histogram[9]

        return fish_histogram
    end

    function run_epoch(fish)
        fish = fish .- 1   
        mask_new_fish = fish .== -1
        fish[mask_new_fish] .= 6
        new_fish = ones(Int, count(mask_new_fish)) * 8
        return vcat(fish, new_fish)
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
        fish_histogram = generate_histogram(parse_input(input))

        n_days = 256

        for i = 1:n_days
            fish_histogram = run_epoch_histogram(fish_histogram)
        end

        return sum(fish_histogram)
    end
end