import re, rdstdin, strutils, sequtils, algorithm

let input = stdin.readAll()
  .splitLines()
  .filterIt(it.len > 0)
  .mapIt(it.findAll(re"\d+").map(parseInt))

var index = 0

proc next(): int =
  result = input[index]
  inc index

var meta = newSeq[int]()

proc readNode(): int =
  let lenChildren = next()
  let lenMeta = next()

  var children = newSeq[int]()

  for i in 0 ..< lenChildren:
    children.add readNode()

  for i in 0 ..< lenMeta:
    let tmp = next()
    meta.add tmp

    if lenChildren == 0:
      result += tmp
    elif tmp <= lenChildren:
      result += children[tmp - 1]

echo readNode() # Part 2
echo meta.foldl(a + b) # Part 1
