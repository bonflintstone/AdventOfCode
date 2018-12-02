import rdstdin
import strutils

var moves = newSeq[int]()
var position = 0
var moveCount = 0

var line: TaintedString
while readlineFromStdin("", line):
  moves.add(parseInt(line))

while position >= 0 and position < len(moves):
  let oldPosition = position

  position += moves[position]
  if(moves[oldPosition] >= 3):
    moves[oldPosition] -= 1
  else:
    moves[oldPosition] += 1

  moveCount += 1

echo moveCount
