# Remarks on Day 5 of Advent of Code
Alright, intervals. I have seen this before. Part 1 seems easily forcable, but I decided not to risk it for part 2 and design a `ClosedInterval` struct to manage my interval calculations. For part 1 I only needed `Base.in`, but for part 2 I needed some more operations. The main struggle for part 2 for me was to find a looping structure that would efficiently catch all cases. I think I managed to find quite an efficient solution today.

## Part 1
So the `ClosedInterval` struct contained two elements, `start` and `stop` (`begin` and `end` are reserved in Julia, so I would rather not publicly denounce myself), so a simple check to see whether a number was in the range was to define `Base.in` as:

```math
i_{\text{start}} \leq x \leq i_{\text{stop}}
```

Looping over all elements then quickly resulted in a workable solution.

## Part 2
Now we're getting into combining overlapping intervals. I defined `overlaps` and `combine` for this reason, and defined `Base.length` of the interval to get the final answer. Here I used a dynamic programming approach to detect the intervals that could be combined, until they were all disjoint. A simple `sum(length, intervals)` would then give me the result.