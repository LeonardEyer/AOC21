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
        input = "0,9 -> 5,9
        8,0 -> 0,8
        9,4 -> 3,4
        2,2 -> 2,1
        7,0 -> 7,4
        6,4 -> 2,0
        0,9 -> 2,9
        3,4 -> 1,4
        0,0 -> 8,8
        5,5 -> 8,2"
        result_1 = 5
        result_2 = 12

        @testset "Part 1" begin
            @test AOC21.Day5.part1(input) == result_1
        end
        @testset "Part 2" begin
            @test AOC21.Day5.part2(input) == result_2
        end
    end

    @testset "Day6" begin
        input = "3,4,3,1,2"
        result_1 = 5934
        result_2 = 26984457539

        @testset "Part 1" begin
            @test AOC21.Day6.part1(input) == result_1
        end
        @testset "Part 2" begin
            @test AOC21.Day6.part2(input) == result_2
        end
    end

    @testset "Day7" begin
        input = "16,1,2,0,4,2,7,1,2,14"
        result_1 = 37
        result_2 = 168

        @testset "Part 1" begin
            @test AOC21.Day7.part1(input) == result_1
        end
        @testset "Part 2" begin
            @test AOC21.Day7.part2(input) == result_2
        end
    end

    @testset "Day8" begin
        input = "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
        edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
        fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
        fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
        aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
        fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
        dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
        bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
        egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
        gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce"
        result_1 = 26
        result_2 = 61229

        @testset "Part 1" begin
            @test AOC21.Day8.part1(input) == result_1
        end
        @testset "Part 2" begin
            #@test AOC21.Day8.part2(input) == result_2
        end
    end

    @testset "Day9" begin
        input = "2199943210
3987894921
9856789892
8767896789
9899965678"
        result_1 = 15
        result_2 = 1134

        @testset "Part 1" begin
            @test AOC21.Day9.part1(input) == result_1
        end
        @testset "Part 2" begin
            @test AOC21.Day9.part2(input) == result_2
        end
    end

    @testset "Day10" begin
        input = "[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]"
        result_1 = 26397
        result_2 = 288957

        @testset "Part 1" begin
            @test AOC21.Day10.part1(input) == result_1
        end
        @testset "Part 2" begin
            @test AOC21.Day10.part2(input) == result_2
        end
    end
    
    @testset "Day11" begin
        input = ""
        result_1 = -1
        result_2 = -1

        @testset "Part 1" begin
            #@test AOC21.Day11.part1(input) == result_1
        end
        @testset "Part 2" begin
            #@test AOC21.Day11.part2(input) == result_2
        end
    end
end