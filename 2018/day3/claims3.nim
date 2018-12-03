# Just trying to solve the same thing better...

import re, rdstdin, strutils, sequtils

func present(s: string): bool = len(s) > 0
let lines = stdin.readAll().splitLines().filter(present)

var fabric: array[1000, array[1000, int]]

iterator eachCell(claim: string): (int, int) =
  let nums = claim.findAll(re(r"\d+")).map(parseInt)

  for x in nums[1]..<nums[1]+nums[3]:
    for y in nums[2]..<nums[2]+nums[4]:
      yield (x, y)

proc prepare() =
  for claim in lines:
    for x, y in eachCell(claim):
      inc fabric[x][y]

proc task1(): int =
  var overlapCount = 0
  for row in fabric:
    for cell in row:
      if cell > 1: inc result

proc task2(): string =
  for claim in lines:
    block checkClaim:
      for x, y in eachCell(claim):
        if fabric[x][y] != 1: break checkClaim

      return claim

prepare()

echo task1()
echo task2()
