using aoc25, Test

cd("..")

@testset "Advent of Code 2025" begin

    @testset "day 1" begin
        @test day01_part1("day01/inputs/day01_test.txt") == 3
        @test day01_part2("day01/inputs/day01_test.txt") == 6
    end


    @testset "day 2" begin
        @test day02_part1("day02/inputs/day02_test.txt") == 1227775554
        @test day02_part2("day02/inputs/day02_test.txt") == 4174379265
    end


    @testset "day 3" begin
        @test day03_part1("day03/inputs/day03_test.txt") == 357
        @test day03_part2("day03/inputs/day03_test.txt") == 3121910778619
    end


    @testset "day 4" begin
        @test day04_part1("day04/inputs/day04_test.txt") == 13
        @test day04_part2("day04/inputs/day04_test.txt") == 43
    end


    @testset "day 5" begin
        @test day05_part1("day05/inputs/day05_test.txt") == 3
        @test day05_part2("day05/inputs/day05_test.txt") == 14
    end


    @testset "day 6" begin
        @test day06_part1("day06/inputs/day06_test.txt") == 4277556
        @test day06_part2("day06/inputs/day06_test.txt") == 3263827
    end


    @testset "day 7" begin
        @test day07_part1("day07/inputs/day07_test.txt")
        @test day07_part2("day07/inputs/day07_test.txt")
    end


    @testset "day 8" begin
        @test day08_part1("day08/inputs/day08_test.txt")
        @test day08_part2("day08/inputs/day08_test.txt")
    end


    @testset "day 9" begin
        @test day09_part1("day09/inputs/day09_test.txt")
        @test day09_part2("day09/inputs/day09_test.txt")
    end


    @testset "day 10" begin
        @test day10_part1("day10/inputs/day10_test.txt")
        @test day10_part2("day10/inputs/day10_test.txt")
    end


    @testset "day 11" begin
        @test day11_part1("day11/inputs/day11_test.txt")
        @test day11_part2("day11/inputs/day11_test.txt")
    end


    @testset "day 12" begin
        @test day12_part1("day12/inputs/day12_test.txt")
        @test day12_part2("day12/inputs/day12_test.txt")
    end
end


