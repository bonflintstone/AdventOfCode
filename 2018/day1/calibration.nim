import rdstdin
import strutils
import sequtils

var changes = newSeq[int]()

var line: TaintedString
while readlineFromStdin("", line):
  changes.add(parseInt(line))

echo changes.foldl(a + b)
