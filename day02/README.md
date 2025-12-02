# Remarks on Day 2 of Advent of Code
Oh no! At first glance this seemed to be a nasty puzzle. Especially if the ranges were large, I wouldn't want to brute force myself into this. To be honest, I actually found getting a working strategy for part 1 the hardest part of this puzzle. After finding a strategy and solving the puzzle for part 1, part 2 was only a piece of cake. 

## Part 1
The key to my solution is to put up walls. For part 1, the biggest constraint was that the repeated number had exactly half the digits of a number within the range. If all numbers in the range had an odd number of digits, we could discard the entire thing. So I started out with counting how many digits we had in the range and discarding the odd numbers. And then, for efficiency, start at the first number within the range that was an invalid id, and increase the "half id" by one each time, until the full id didn't fit in the range anymore. In this section, creating the full ids from the halves was done using a custom `repnum` function, that did the following:

$$ y = 10^{d(x)} + x $$
Where $d(x)$ is the number of digits of a number $x$.

## Part 2
For this, I kind of did a similar thing, but now I started with a `partial_id` of `1`, and checked every repeat within the range using a new method of the `repnum` function, for which the output is defined by the following recursive relationship:

$$ y_{n+1} = y_n \cdot 10^{d(x)} + y_1,~\quad~y_1=x  $$

Adding `1` to my partial id every loop and checking until it was not in range anymore did the trick in full. For each partial id $x$, I limited $n$ to be:
$$ n \in [2, d(r_2)\div d(x)]