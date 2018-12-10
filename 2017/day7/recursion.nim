import re, rdstdin, strutils, sequtils, algorithm

let input = stdin.readAll().splitLines()

var children = newSeq[string]()

for line in input:
  if not line.contains("->"): continue

  for child in line.split("-> ")[1].split(", "):
    children.add(child)

for line in input:
  if not children.contains(line.split(" ")[0]):
    echo line.split(" ")[0]
