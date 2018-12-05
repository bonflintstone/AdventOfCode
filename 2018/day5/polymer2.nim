import re, rdstdin, strutils, sequtils, algorithm

func present(s: string): bool = len(s) > 0
let lines = stdin.readAll().splitLines().filter(present).sorted(cmp)
let input = lines[0]

func charRegexpart(c: char): string =
  "($1$2)|($2$1)" % [$c, $c.toUpperAscii]

let regex = toSeq('a' .. 'z')
  .map(charRegexpart)
  .foldl(a & "|" & b)
  .re

proc reduce(s: string): string =
  var tmp = s
  while true:
    result = tmp.replace(regex)
    if tmp == result: break
    tmp = result

proc withoutChar(s: string, c: char): string =
  s.replace($c).replace($c.toUpperAscii)

proc smallesReduction(): int =
  toSeq('a' .. 'z')
    .map(proc(c: char): int = input.withoutChar(c).reduce().len)
    .foldl(if a < b: a else: b)

echo input.reduce.len # Part1
echo smallesReduction() # Part2
