import rdstdin
import strutils
import sequtils

var lines = newSeq[seq[string]]()
var line: TaintedString

while readLineFromStdin("", line):
  lines.add(splitWhitespace(line))

lines.keepIf do (passphrase: seq[string]) -> bool :
  passphrase.deduplicate == passphrase

echo lines.len
