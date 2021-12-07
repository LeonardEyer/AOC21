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
        result_2 = 230

        @testset "Part 1" begin
            @test AOC21.Day3.part1(input) == result_1
        end
        @testset "Part 2" begin
            @test AOC21.Day3.part2(input) == result_2
        end
    end

    @testset "Day4" begin
        input = "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

        22 13 17 11  0
         8  2 23  4 24
        21  9 14 16  7
         6 10  3 18  5
         1 12 20 15 19
        
         3 15  0  2 22
         9 18 13 17  5
        19  8  7 25 23
        20 11 10 24  4
        14 21 16 12  6
        
        14 21 17 24  4
        10 16 15  9 19
        18  8 23 26 20
        22 11 13  6  5
         2  0 12  3  7
        "
        result_1 = 4512
        result_2 = 1924

        @testset "Part 1" begin
            @test AOC21.Day4.part1(input) == result_1
        end
        @testset "Part 2" begin
            @test AOC21.Day4.part2(input) == result_2
        end
    end

    @testset "Day5" begin
        input = ""
        result_1 = 0
        result_2 = 0

        @testset "Part 1" begin
            #@test AOC21.Day5.part1(input) == result_1
        end
        @testset "Part 2" begin
            #@test AOC21.Day5.part2(input) == result_2
        end
    end

    @testset "Day6" begin
        input = ""
        result_1 = 0
        result_2 = 0

        @testset "Part 1" begin
            #@test AOC21.Day6.part1(input) == result_1
        end
        @testset "Part 2" begin
            #@test AOC21.Day6.part2(input) == result_2
        end
    end

    @testset "Day7" begin
        input = ""
        result_1 = 0
        result_2 = 0

        @testset "Part 1" begin
            #@test AOC21.Day7.part1(input) == result_1
        end
        @testset "Part 2" begin
            #@test AOC21.Day7.part2(input) == result_2
        end
    end
end