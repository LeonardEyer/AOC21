using AOC21
using Test

input = [199 200 208 210 200 207 240 269 260 263]
n_increases = 7
three_sum_n_increases = 5

@testset "Basic Tests" begin

    @testset "Part 1" begin
        @test AOC21.Day1.count_increasing(input) == n_increases
    end
    @testset "Part 2" begin
        @test AOC21.Day1.count_three_sum_increasing(input) == three_sum_n_increases
    end
end