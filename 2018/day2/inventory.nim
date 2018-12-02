import rdstdin
import strutils
import sequtils

var ids = newSeq[string]()

var num2 = 0
var num3 = 0

var line: TaintedString
while readlineFromStdin("", line):
  ids.add(line)

for id in ids:
  var found2 = false
  var found3 = false

  for letter in id.items:
    if not found2 and id.count(letter) == 2:
      num2 += 1
      found2 = true
    if not found3 and id.count(letter) == 3:
      num3 += 1
      found3 = true

echo num2 * num3
