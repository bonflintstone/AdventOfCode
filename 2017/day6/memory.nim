import re, rdstdin, strutils, sequtils, algorithm

let input = stdin.readAll().findAll(re(r"\d+")).map(parseInt)

var history = newSeq[seq[int]]()

history.add(input)

while true:
  var last = history[history.len - 1]

  let maxVal = last.max
  let maxIndex = last.find(maxVal)

  last[maxIndex] = 0

  for i in 1 .. maxVal:
    inc(last[(maxIndex + i) mod last.len])

  if history.count(last) > 1:
    break

  history.add(last)

echo history.len - history.find(history[history.len - 1]) - 1
