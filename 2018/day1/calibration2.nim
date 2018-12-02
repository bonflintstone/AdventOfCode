import rdstdin
import strutils
import sequtils

var changes = newSeq[int]()
var frequency = 0
var history = @[0]

var line: TaintedString
while readlineFromStdin("", line):
  changes.add(parseInt(line))

while true:
  for change in changes:
    frequency += change

    if history.find(frequency) != -1:
      echo frequency
      system.quit()

    history.add(frequency)
