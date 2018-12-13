import re, rdstdin, strutils, sequtils, algorithm, streams, terminal, os
import unpack

var map = stdin.readAll().splitLines()

type
  Direction = enum
    Right, Up, Left, Down
  Cart = ref object of RootObj
    x, y, turns: int
    dir: Direction
    collided: bool

var carts = newSeq[Cart]()

proc print() =
  for y in 0 ..< map.len:
    for x in 0 ..< map[y].len:
      var here = carts.filterIt(it.x == x and it.y == y)

      if here.len > 0:
        case here[0].dir:
          of Left: stdout.write '<'
          of Up: stdout.write '^'
          of Down: stdout.write 'v'
          of Right: stdout.write '>'
          else: discard
      else:
        stdout.write(map[y][x])
    echo()

for y in 0 ..< map.len:
  for x in 0 ..< map[y].len:
    var dir: Direction

    case map[y][x]:
      of '<': dir = Left
      of '^': dir = Up
      of 'v': dir = Down
      of '>': dir = Right
      else: continue

    carts.add(Cart(x: x, y: y, dir: dir, turns: 0, collided: false))

    case dir:
      of Left, Right: map[y][x] = '-'
      of Up, Down: map[y][x] = '|'

proc sort() =
  carts = carts.sortedByIt(it.y * 100000 + it.x)

proc calcCollided() =
  for y in 0 ..< map.len:
    for x in 0 ..< map[y].len:
      var here = carts.filterIt(it.x == x and it.y == y)
      if here.len > 1:
        for cart in here:
          cart.collided = true

proc move() =
  for cart in carts:
    calcCollided()

    if not carts.contains(cart): continue

    case map[cart.y][cart.x]:
      of '|', '-': discard
      of '/':
        case cart.dir:
          of Left: cart.dir = Down
          of Up: cart.dir = Right
          of Right: cart.dir = Up
          of Down: cart.dir = Left
      of '\\':
        case cart.dir:
          of Left: cart.dir = Up
          of Up: cart.dir = Left
          of Right: cart.dir = Down
          of Down: cart.dir = Right
      of '+':
        if cart.turns mod 3 != 1:
          cart.dir = Direction((ord(cart.dir) + (cart.turns mod 3) + 1) mod 4)
        inc cart.turns
      else: discard

    case cart.dir:
      of Left: dec cart.x
      of Up: dec cart.y
      of Right: inc cart.x
      of Down: inc cart.y

while carts.len > 1:
  sort()
  print()
  sleep(150)
  move()
  carts.keepItIf(not it.collided)

echo carts.mapIt((x: it.x, y: it.y))
