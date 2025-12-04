# Remarks on Day 4 of Advent of Code
The first of day 4 was no difficult exercise. Similarly, I had solved part 2 very quickly with a relatively inefficient approach. However, it would still work within 10 seconds (thank you, Julia). It could probably be done more efficiently, so I thought about doing that. I found that I initially checked all rolls in the entire warehouse for their neighbors, but I could also add a dynamic list of rolls to check, which are all the rolls initially, but after that, I only had to check the neighbors of the ones I removed. That was the biggest win in performance. While the code doesn't look nearly as elegant as I'd wanted, it works.

## Part 1
I used Julia's `CartesianIndex` type to keep all the locations of the rolls in a vector. I constructed a `neighborsin(index, indices, n)` function, which checks whether an index has less than `n` neighbors in the list of `indices`. Running that through the map of rolls resulted in a quick answer.

## Part 2
For part 2, I did the same thing but dynamically removing rolls from the map. I also added the `neighbors` function to find the neighbors of the removed rolls. 