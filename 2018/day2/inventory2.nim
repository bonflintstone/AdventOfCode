import rdstdin
import strutils
import sequtils

var ids = newSeq[string]()

var line: TaintedString
while readlineFromStdin("", line):
  ids.add(line)

func compare(id1: string, id2: string): seq[int] =
  result = @[]

  for i, zip in toSeq(id1.items).zip(toSeq(id2.items)):
    if zip.a != zip.b:
      result.add(i)

for i, id1 in ids:
  for j, id2 in ids:
    if i <= j: continue
    if compare(id1, id2).len == 1:
      let index = compare(id1, id2)[0]

      echo "$1$2" % [id1[0..(index-1)], id1[(index+1)..id1.len]]
