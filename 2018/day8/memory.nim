import re, rdstdin, strutils, sequtils, algorithm

func present(s: string): bool = len(s) > 0
let input = stdin.readAll().splitLines()
  .filter(present)[0].findAll(re(r"\d+")).map(parseInt)

var index = 0

proc next(): int =
  result = input[index]
  inc index

var meta = newSeq[int]()

proc readNode(): int =
  let numChilds = next()
  let numMeta = next()

  var childs = newSeq[int]()

  for i in 0 ..< numChilds:
    childs.add(readNode())

  for i in 0 ..< numMeta:
    let tmp = next()
    meta.add(tmp)

    if numChilds == 0:
      result += tmp
    else:
      if tmp <= numChilds:
        result += childs[tmp - 1]

echo readNode() # Part 2
echo meta.foldl(a + b) # Part 1
