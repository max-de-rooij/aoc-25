# Remarks on Day 6 of Advent of Code
This seemed like a very easy puzzle for halfway, but then again, part 1 offers no guarantees for part 2. Part 1 was done very quickly. I though part 2 was a piece of cake, but it turns out I read it incorrectly. The actual problem turned out to require some creativity, but it wasn't particularly hard to solve. 

## Part 1
I think this part requires no significant explanation. I read all the lines and operators, and then enumerated through the operators, accumulating all the lines while doing so.

## Part 2
This one turned out to be a bit more difficult. Luckily, the operators are commutative so we could decide upon the order of finding the numbers. My solution required a double loop; one loop for the operators, and one for the number reading mechanism. Interestingly here, the index for the while loop is not reset every iteration of the for-loop, but it is kept all through. Too bad the end of the file did not contain any spaces, so that required another bounds checking if-statement, which I solved in a bit of an ugly way, but if it works, it works.