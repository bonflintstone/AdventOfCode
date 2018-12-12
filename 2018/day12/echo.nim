import re, rdstdin, strutils, sequtils, algorithm, streams, terminal
import unpack

let input = stdin.readAll()
let lines = input.splitLines()

var current: array[-1000..2000, char]
let rules = lines[2 .. lines.high]
  .map(proc(s: string): seq[string] = s.split(" => "))
  .filterIt(it[it.high] == "#")

for i in current.low .. current.high:
  current[i] = '.'
for i, c in lines[0].split(": ")[1]:
  current[i] = c

proc apply() =
  var setPlant = newSeq[int]()

  for i in current.low + 2 .. current.high - 2:
    for rule in rules:
      if current[i-2 .. i+2] == rule[0]:
        setPlant.add(i)
        
  for i in current.low .. current.high:
    if setPlant.contains(i):
      current[i] = '#'
    else:
      current[i] = '.'

proc count(): int =
  for i, p in current:
    if p == '#':
      result += i

for i in 1 ..< 20:
  apply()

echo count()
