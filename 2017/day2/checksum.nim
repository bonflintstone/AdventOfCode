import rdstdin
import strutils
import sequtils

var lines = newSeq[seq[int]]()
var line: TaintedString

while readLineFromStdin("", line):
  var numLine = newSeq[int]()

  for number in splitWhitespace(line):
    numLine.add(number.parseInt)

  lines.add(numLine)

proc diffMinMax(line: seq[int]): int =
  let imax = foldl(line, max(a, b))
  let imin = foldl(line, min(a, b))
  result = imax - imin

echo lines.map(diffMinMax).foldl(a + b)
