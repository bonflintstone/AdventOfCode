import re, rdstdin, strutils, sequtils, algorithm, lists, macros

const listSize = 5
let input = stdin.readAll().findAll(re"\d+").map(parseInt)

var skip = 0
var index = 0
var list: array[5, int]
for i in list.low .. list.high:
  list[i] = i

macro `@`(list, accessor: untyped): untyped =
  newNimNode(nnkBracketExpr).add(
    list,
    newNimNode(nnkInfix).add(
      newIdentNode("mod"),
      accessor,
      newIntLitNode(listSize)
    )
  )

proc reverse(length: int) =
  for i in index ..< index + length:
    let j = index + length - i - 1
    let tmp = list@i
    list@i = list@j
    list@j = tmp
