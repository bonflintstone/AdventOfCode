import re, rdstdin, strutils, sequtils, algorithm

let input = stdin.readAll()
var index = 0

var totalScore = 0
var currentGroupScore = 0
var nonCancelled = 0

proc parseGarbage() =
  while input[index] != '>':
    if input[index] == '!':
      inc index
    else:
      inc nonCancelled
    inc index
  dec nonCancelled

proc startGroup() =
  currentGroupScore += 1

proc endGroup() =
  totalScore += currentGroupScore
  currentGroupScore -= 1

proc parse() =
  case input[index]:
    of '<': parseGarbage()
    of '{': startGroup()
    of '}': endGroup()
    of '!': inc index
    else: discard

  inc index

while index < input.len:
  parse()

echo totalScore
echo nonCancelled
