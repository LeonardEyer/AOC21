using AOC21
using Test


@testset "Basic Tests" begin

    @testset "Day1" begin
        input = [199 200 208 210 200 207 240 269 260 263]
        result_1 = 7
        result_2 = 5

        @testset "Part 1" begin
            @test AOC21.Day1.part1(input) == result_1
        end
        @testset "Part 2" begin
            @test AOC21.Day1.part2(input) == result_2
        end
    end

    @testset "Day2" begin
        input = ["forward 5" "down 5" "forward 8" "up 3" "down 8" "forward 2"]
        result_1 = 150
        result_2 = 900

        @testset "Part 1" begin
            @test AOC21.Day2.part1(input) == result_1
        end
        @testset "Part 2" begin
            @test AOC21.Day2.part2(input) == result_2
        end
    end

    @testset "Day3" begin
        input = ["00100" "11110" "10110" "10111" "10101" "01111" "00111" "11100" "10000" "11001" "00010" "01010"]
        result_1 = 198
        result_2 = -1

        @testset "Part 1" begin
            @test AOC21.Day3.part1(input) == result_1
        end
        @testset "Part 2" begin
            @test AOC21.Day3.part2(input) == result_2
        end
    end
end