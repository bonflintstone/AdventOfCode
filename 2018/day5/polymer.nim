import re, rdstdin, strutils, sequtils, algorithm

func present(s: string): bool = len(s) > 0
let lines = stdin.readAll().splitLines().filter(present).sorted(cmp)
let input = lines[0]

proc reduce(s: var string) =
  for i in (0 ..< s.high):
    let c1 = s[i]
    let c2 = s[i + 1]

    if cmpIgnoreCase($c1, $c2) == 0 and c1 != c2:
      s = s.replace(s[i..i+1], "")
      return

proc reducedLen(s: string): int =
  var tmp = s

  while true:
    let  before = tmp
    tmp.reduce
    if(tmp == before):
      break

  return tmp.len

let results = toSeq('a' .. 'z').map(proc(c: char): int =
  let red = input.replace($c, "").replace($toUpperAscii(c), "")

  return reducedLen(red)
)

echo reducedLen(input) # part 1
echo results.sorted(cmp)[0] # part 2
