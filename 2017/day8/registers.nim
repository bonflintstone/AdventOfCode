import re, rdstdin, strutils, sequtils, algorithm, macros, tables
import unpack

let input = stdin.readAll().splitLines()

var registers = newTable[string, int]()

proc register(s: string): int = registers.getOrDefault(s, 0)
var maximum = 0

for line in input:
  if line == "": continue

  [changeReg, changeMode, changeAmount, _, checkReg, checkExp, checkAmount] <-
    line.findAll(re"\S+")

  var doIt: bool
  case checkExp:
    of "<": doIt = register(checkReg) < checkAmount.parseInt
    of "<=": doIt = register(checkReg) <= checkAmount.parseInt
    of ">": doIt = register(checkReg) > checkAmount.parseInt
    of ">=": doIt = register(checkReg) >= checkAmount.parseInt
    of "==": doIt = register(checkReg) == checkAmount.parseInt
    of "!=": doIt = register(checkReg) != checkAmount.parseInt

  if doIt:
    registers[changeReg] = register(changeReg)

    case changeMode:
      of "inc": registers[changeReg] += changeAmount.parseInt
      of "dec": registers[changeReg] -= changeAmount.parseInt
  for v in registers.values:
    if v > maximum: maximum = v

echo maximum
