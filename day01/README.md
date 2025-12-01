# Remarks on Day 1 of Advent of Code
Part 1 was quite easy and quickly done. I'd like to say my solution is quite elegant. Much less can be said for day 2, which was unsuspectingly quite challenging because of some edge cases, which made me go through the output for some debugging. Undoubtedly, there may be better solutions than mine, but I am glad that I obtained a solution that works. 

## Part 1
For part 1, I ran an accumulated sum (`cumsum`) with each element being `mod(100)`, and mapped the Julia `iszero` function to this result.

## Part 2
For part 2, I used a similar accumulation, but for each step, I evaluated the number of zero-crossings using a custom function. This custom function initially checks whether we land exactly on zero (1 zero crossing). Then, we evaluated the distance traveled to get there. If we went below zero, we know we have crossed a zero (except for when we started at zero, then we may not have). This starting point is checked through the previous start point being nonzero. We also subtract one if the end point is zero, because we already counted that. If we go above a 100, we don't have to check this, we know we have made a zero-crossing. 

We accumulate the zero-crossings similarly to part 1 and sum them to obtain our answer.