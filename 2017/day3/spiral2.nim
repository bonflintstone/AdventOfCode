import tables
import sequtils
import strutils
import os

if paramCount() != 1:
  echo "Invalid arg count"
  system.quit()

let input = parseInt(paramStr(1)) - 1

type
  Direction {.pure.} = enum
    Right, Top, Left, Down

  Point2d = object
    x, y: int

var direction = Top
var numberCoords = @[(Point2d(x: 0, y: 0), 1), (Point2d(x: 1, y: 0), 1)]

func currentCoord(): Point2d =
  numberCoords[numberCoords.high][0]

func nextDirection(d: Direction): Direction =
  if d == Direction.high:
    Direction.low
  else:
    d.succ

func nextDirection(): Direction =
  nextDirection(direction)

func pointInDirection(p: Point2d, d: Direction): Point2d =
  case d:
    of Right:
      Point2d(x: p.x + 1, y: p.y)
    of Top:
      Point2d(x: p.x, y: p.y - 1)
    of Left:
      Point2d(x: p.x - 1, y: p.y)
    of Down:
      Point2d(x: p.x, y: p.y + 1)

func getPoint2d(t: tuple): Point2d =
  t[0]

proc nextPoint(): Point2d =
  result = pointInDirection(currentCoord(), nextDirection())

  if numberCoords.map(getPoint2d).find(result) == -1:
    direction = nextDirection()
  else:
    result = pointInDirection(currentCoord(), direction)

proc around(p: Point2d): int =
  var points = newSeq[Point2d]()

  for d in (Direction.low..Direction.high):
    let newP = pointInDirection(p, d)
    points.add(newP)
    points.add(pointInDirection(newP, d.nextDirection()))

  let nums = numberCoords.map do (t: tuple) -> int:
    if points.find(t[0]) == -1:
      return 0
    else:
      return t[1]

  nums.foldl(a + b)

var nextN = 0

while nextN < input:
  let next = nextPoint()
  nextN = around(next)

  numberCoords.add((next, nextN))

echo nextN
