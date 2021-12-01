include("../src/AOC21.jl")
using .Day1
using Test

input = [199 200 208 210 200 207 240 269 260 263]

@testset "Basic Tests" begin

    @testset "forloop" begin
        @test forLoop.count_increasing(input) == 7 
    end
end