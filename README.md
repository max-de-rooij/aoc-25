![](https://img.shields.io/badge/day%20📅-11-blue)
![](https://img.shields.io/badge/stars%20⭐-22-yellow)
![](https://img.shields.io/badge/days%20completed-11-red)

# Advent of Code 2025
This repository contains my solutions for the Advent of Code 2025 programming challenges.[^aoc] Each day's challenge is implemented in a separate folder, organized by day.

> [!NOTE]
> For my attempts, I consider several rules for myself. All solutions are written and thought of **entirely** without the use of AI tools such as Copilot, ChatGPT, or Claude Sonnet. I try to finish most of the solutions without any packages. For this year, I have used no packages for all solutions except:
> - Day 10, part 2. Used `JuMP` and `HiGHS` for the ILP solver.
>
> Any other packages in `Project.toml` are used for testing and benchmarking solutions, or to set up the folder structure.

## Structure
- Each day's solution is located in a folder named `dayXX`, where `XX` is the day number (e.g., `day01`, `day02`, etc.).
- Each folder contains:
  - `solution.jl`: The main solution file for that day's challenge.
  - `README.md`: Additional notes or explanations about the solution. 

_In accordance with the Advent of Code rules, I will not share any input data or specific challenge details in this repository. Inputs are expected to be provided by the user when running the solutions._

## Usage
To run a solution for a specific day, navigate to the corresponding folder and execute the `solution.jl` file using Julia. Make sure to provide the necessary input data as required by the challenge.

## Julia Testing
The `test` folder contains tests with expected outputs for the `test_cases` given in the Advent of Code puzzles. These `test_cases` are expected to be in the `dayXX/inputs/dayXX_test.txt` file where `XX` indicates the day (`01` for day 1, `02` for day 2, etc.) 

[^aoc]:
    [Advent of Code][aoc] – An annual event of Christmas-oriented programming challenges started December 2015.
    Every year since then, beginning on the first day of December, a programming puzzle is published every day for twenty-five days.
    You can solve the puzzle and provide an answer using the language of your choice.

[aoc]: https://adventofcode.com
