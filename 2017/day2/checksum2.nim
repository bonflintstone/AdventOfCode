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

proc evenDiv(line: seq[int]): int =
  for divident in line:
    for divisor in line:
      if divident == divisor: continue

      if divident / divisor == float(divident div divisor):
        return divident div divisor

echo lines.map(evenDiv).foldl(a + b)
