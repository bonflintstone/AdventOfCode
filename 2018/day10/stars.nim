import re, rdstdin, strutils, sequtils, algorithm, streams, terminal

func present(s: string): bool = len(s) > 0
let input = newFileStream("./input.txt").readAll().splitLines()
  .filter(present)

type
  Star = object of RootObj
    x, y, vx, vy: int

var stars = newSeq[Star]()

for line in input:
  let ls = line.findAll(re(r"-?\d+")).map(parseInt)
  stars.add(Star(x: ls[0], y: ls[1], vx: ls[2], vy: ls[3]))

var maxX, minX, kmaxY, kminY

proc reBound() =
  maxX = stars.mapIt(it.x).max
  minX = stars.mapIt(it.x).min
  maxY = stars.mapIt(it.y).max
  minY = stars.mapIt(it.y).min

proc print() =
  for y in minY..maxY:
    for x in minX..maxX:
      if stars.anyIt(it.x == x and it.y == y):
        stdout.write("#")
      else:
        stdout.write(".")
    echo ""

proc move() =
  for i, star in stars:
    stars[i] = Star(x: star.x + star.vx,
                    y: star.y + star.vy,
                    vx: star.vx, vy: star.vy)

var count = 0

while true:
  count += 1
  move()
  reBound()

  if maxY - minY < 12:
    echo count
    print()
    echo "----"
