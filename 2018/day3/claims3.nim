# Just trying to solve the same thing better...

import re, rdstdin, strutils, sequtils

var lines = newSeq[string]()
var line: TaintedString
while readlineFromStdin("", line):
  lines.add(line)

var fabric: array[1000, array[1000, int]]

iterator eachCell(claim: string): (int, int) =
  let nums = claim.findAll(re(r"\d+")).map(parseInt)

  for x in nums[1]..nums[1]+nums[3]:
    for y in nums[2]..nums[2]+nums[4]:
      yield (x, y)

for claim in lines:
  for x, y in eachCell(claim):
    fabric[x][y] += 1

for claim in lines:
  block checkClaim:
    for x, y in eachCell(claim):
      if fabric[x][y] != 1: break checkClaim

    echo claim
    break
