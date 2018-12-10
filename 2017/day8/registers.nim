import re, rdstdin, strutils, sequtils, algorithm, macros, tables

let input = stdin.readAll().splitLines()

var registers = newTable[string, int]()

dumpTree:
  if registers.getOrDefault("a", 0) > 1:
    registers["b"] = registers.getOrDefault("b", 0) + 5

macro changeRegister(register: string, change: NimNode): typed =
  newAssignment(
    newTree(
      nnkBracketExpr,
      [
        newIdentNode("registers"),
        register
      ]
    ),
    newIntLitNode(20)
  )

macro checkRegister(checkReg, checkExp: string, checkAmout: int): typed =
  newCall(newIdentNode(checkExp))

for line in input:
  let l = line.findAll(re"\S+")

  let changeReg = l[0]
  let changeMode = l[1]
  let changeAmount = l[2].parseInt
  let checkReg = l[4]
  let checkExp = l[5]
  let checkAmount = l[6].parseInt

echo registers
