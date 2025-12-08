# Remarks on Day 8 of Advent of Code
Today was remarkably difficult. I'm not proud of my code cleanliness, but it runs and works in a decent time, so I'm happy.

## Part 1
My idea here was to keep a stack of distances and then use this to build the circuits. Then it was just simple merging of connections and we got the answer.

## Part 2
Over here, we needed to loop over this until the circuit was completely connected. I used the same stack I built before and refilled it with a `min_distance` to compute the distances in a batched way. It is not particularly efficient but it works in a decent amount of time.