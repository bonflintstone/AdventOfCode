import re, rdstdin, strutils, sequtils, algorithm, tables

type
  Coord = object of RootObj
    x, y: int

func present(s: string): bool = len(s) > 0
func toCoord(cs: seq[int]): Coord = Coord(x: cs[0], y: cs[1])

const coords = staticRead("input.txt")
  .splitLines()
  .filter(present)
  .map(proc(s: string): Coord =
    s.split(", ").map(parseInt).toCoord()
  )

const minX = coords.foldl(if a.x < b.x: a else: b).x
const maxX = coords.foldl(if a.x > b.x: a else: b).x
const minY = coords.foldl(if a.y < b.y: a else: b).y
const maxY = coords.foldl(if a.y > b.y: a else: b).y

const adjustedCoord = coords.map(proc(c: Coord): Coord =
  Coord(x: c.x - minX, y: c.y - minY)
)

type
  GridRow = array[maxY - minY + 1, int]
  Grid = array[maxX - minX + 1, GridRow]

var grid: Grid

func getDistance(c: Coord, x, y: int): int =
  abs(c.x - x) + abs(c.y - y)

var regionSize = 0

for x in 0 ..< grid.len:
  for y in 0 ..< grid[x].len:
    var distanceAll = adjustedCoord
      .map(proc(c: Coord): int = getDistance(c, x, y))
      .foldl(a + b)

    if(distanceAll < 10000):
      inc regionSize

echo regionSize
