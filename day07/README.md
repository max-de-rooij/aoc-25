# Remarks on Day 7 of Advent of Code
Oh this seems like a challenging one! Great! The first puzzle was not at all too difficult, and I was smart enough to avoid the bounds of the manifold. Part 2 was a typical advent of code puzzle; seems doable at first, but then you find out that your solution will never work. I had to find something smarter. This smarter solution took a bit of time, but I think I've managed to come up with an elegant solution to the problem.

## Part 1
So here I kept a list of beams that were there. For every beam, I'd see if there was a splitter on the next line and added the two adjacent positions to a new list, otherwise, I'd add the current position to the new list, and replaced my old list with a new one. Of course I made sure here that the new positions were within the bounds and the beams were not counted double.

## Part 2
Initially, I tried the same thing here, but then keeping a list of lists of positions, but that turned out to be impossible here. My final solution uses a dictionary that keeps the amount of timelines per column of the map. I looped through the rows and if I encountered a splitter, I'd set the timelines on the current column to 0 and added the timelines to both columns adjacent, taking into account the bounds of the manifold. Looping through the rows this worked great!