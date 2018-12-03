import rdstdin
import strutils
import sequtils

var claims = newSeq[string]()
var fabric: array[1000, array[1000, int]]

var line: TaintedString
while readlineFromStdin("", line):
  claims.add(line)

for claim in claims:
  let claimData = claim.split(" ")
  let claimNo = claimData[0]
  let pos = claimData[2]
  let size = claimData[3]

  let x = parseInt(pos.split(",")[0])
  let y = parseInt(pos.split(",")[1].split(":")[0])
  let width = parseInt(size.split("x")[0])
  let height = parseInt(size.split("x")[1])

  for i in (x..x+width-1):
    for j in (y..y+height-1):
      fabric[i][j] += 1

var count = 0

for column in fabric:
  for cell in column:
    if cell > 1:
      count += 1

echo count
