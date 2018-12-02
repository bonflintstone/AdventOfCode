import rdstdin
import strutils
import sequtils
import algorithm

var lines = newSeq[seq[string]]()
var line: TaintedString

while readLineFromStdin("", line):
  lines.add(splitWhitespace(line))

proc annagramId(word: string): seq[char] =
  toSeq(word.items).sorted(cmp)

lines.keepIf do (passphrase: seq[string]) -> bool :
  let annis = passphrase.map(annagramId)
  annis.deduplicate == annis

echo lines.len
