import rdstdin, sequtils, strutils, re, tables

let input = stdin.readAll().findAll(re(r"\d+")).map(parseInt)

proc run(noun, verb: int): int =
  var program: seq[int] = input
  var position = 0

  program[1] = noun
  program[2] = verb

  while true:
    if(program[position] == 99):
      return program[0]

    let a = program[position + 1]
    let b = program[position + 2]
    let register = program[position + 3]

    case(program[position])
    of 1:
      program[register] = program[a] + program[b]
      position += 4
    of 2:
      program[register] = program[a] * program[b]
      position += 4
    else:
      echo "error at ", position
      quit()

for noun in 0..99:
  for verb in 0..99:
    let result = run(noun, verb)

    # echo result

    if(result == 19690720):
      echo noun, verb
