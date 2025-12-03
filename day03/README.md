# Remarks on Day 3 of Advent of Code
This day was remarkably easy to solve. I was done quickly with the puzzle, and only made a small mistake with indexing in part 2, but that was also solved relatively quickly.

## Part 1
This part was very simple, we'd need the largest number, by selecting two digits. Given a list of digits $l$:
$$ l(1,n) = [d_1, d_2, d_3, \cdots, d_n] $$

The first digit of the number is most important here. For selecting the first digit, I took the list, except for the last digit (naturally, if the largest number of the list, except $d_n$ is equal to digit $d_{n-1}$, the maximum number is always going to be combining $d_{n-1}$ and $d_n$). We also don't use the last digit initially, because we always need to select two digits from left to right. Our final solution $r$ is then for a list $l$:

$$ i_1 = \arg \max{l(1,n-1)} $$
$$ r_2 = \max{l(i_1+1, n)} $$
$$ r_1 = l(i_1) $$
$$ r = 10\cdot r_1 + r_2 $$

## Part 2
For part 2, we actually did the same thing, but then recursively. For selecting $m$ batteries, we start by searching $l(1, n - m + 1)$ for the maximum index ($i_1$), and then moving on to $l(i_1+1, n - m + 2)$, etcetera. 