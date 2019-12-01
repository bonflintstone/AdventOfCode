import rdstdin, sequtils, strutils, re, strformat

let input = stdin.readAll().split(", ")

type Position = object
  x: int
  y: int

type
  Direction = enum
    north, east, south, west

func right(dir: Direction): Direction =
  case dir
  of north: east
  of west: north
  of south: west
  of east: south

func left(dir: Direction): Direction =
  dir.right.right.right

func eq(p1: Position, p2: Position): bool =
  p1.x == p2.x and p1.y == p2.y

var positions = @[Position(x: 0, y: 0)]
var direction = north

proc position(): Position =
  positions[^1]

func abs(i: int): int =
  result = i

  if(i < 0): return -result

func distance(pos: Position): int =
  abs(pos.x) + abs(pos.y)

proc move(steps: int) =
  var i = 0
  while i < steps:
    i += 1

    case direction
    of east: positions.add(Position(x: position().x + 1, y: position().y))
    of west: positions.add(Position(x: position().x - 1, y: position().y))
    of north: positions.add(Position(x: position().x, y: position().y + 1))
    of south: positions.add(Position(x: position().x, y: position().y - 1))

    if(positions[0..^2].anyIt(it.eq(position()))):
      echo(position().distance)

for line in input:
  case line[0]
  of 'R': direction = direction.right
  of 'L': direction = direction.left
  else: discard

  move(line[1..^1].join().strip().parseInt())
