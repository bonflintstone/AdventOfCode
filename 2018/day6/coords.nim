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

for x in 0 ..< grid.len:
  for y in 0 ..< grid[x].len:
    var closest = -1
    var distance = int.high

    for i, coord in adjustedCoord:
      if getDistance(coord, x, y) < distance:
        distance = getDistance(coord, x, y)
        closest = i
      elif getDistance(coord, x, y) == distance:
        closest = -1

    grid[x][y] = closest

var infinites = newSeq[int]()
for x in 0 ..< grid.len:
  for y in @[0, grid[x].len - 1]:
    infinites.add(grid[x][y])
for x in @[0, grid.len - 1]:
  for y in 0 ..< grid[x].len:
    infinites.add(grid[x][y])
    
var count = newCountTable[int]()
for x in 0 ..< grid.len:
  for y in 0 ..< grid[x].len:
    let here = grid[x][y]

    if here >= 0 and not infinites.contains(here):
      count.inc(here)

echo count.largest[1]
