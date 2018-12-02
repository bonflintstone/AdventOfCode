import rdstdin
import strutils

var moves = newSeq[int]()
var position = 0
var moveCount = 0

var line: TaintedString
while readlineFromStdin("", line):
  moves.add(parseInt(line))

while position >= 0 and position < len(moves):
  moves[position] += 1
  position += moves[position] - 1
  moveCount += 1

echo moveCount
