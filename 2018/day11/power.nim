import re, rdstdin, strutils, sequtils, algorithm, streams, terminal
import unpack

let serialNumber = 6042

var map: array[300, array[300, int]]
for x in 0..299:
  for y in 0..299:
    let rackId = x + 10
    let powerLevel = rackId * y + serialNumber

    let thing = "00" & $(powerLevel * rackId)
    let hundret = parseInt($(thing[thing.len - 3]))

    map[x][y] = hundret - 5

proc calcGrid(x, y, s: int): int =
  for xi in x ..< x + s:
    for yi in y ..< y + s:
      result += map[xi][yi]

var maxed, maxX, maxY, maxS = 0

for x in 0..297:
  for y in 0..297:
    for s in 1 ..< min(300 - x, 300 - y):
      let c = calcGrid(x, y, s)

      if(c > maxed):
        [maxed, maxX, maxY, maxS] <-- [c, x, y, s]

echo maxX, ",", maxY, ",", maxS
