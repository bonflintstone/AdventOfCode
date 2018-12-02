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
var numberCoords = @[Point2d(x: 0, y: 0), Point2d(x: 1, y: 0)]

func distance(p: Point2d): int =
  abs(p.x) + abs(p.y)

func currentCoord(): Point2d =
  numberCoords[numberCoords.high]

func nextDirection(): Direction =
  if direction == Direction.high:
    Direction.low
  else:
    direction.succ

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

proc nextPoint(): Point2d =
  result = pointInDirection(currentCoord(), nextDirection())

  if numberCoords.find(result) == -1:
    direction = nextDirection()
  else:
    result = pointInDirection(currentCoord(), direction)

proc findInInput() =
  while numberCoords.high < input:
    numberCoords.add(nextPoint())

  echo numberCoords[input].distance

findInInput()
