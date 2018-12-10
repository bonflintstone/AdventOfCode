import re, rdstdin, strutils, sequtils, algorithm, lists

let input = stdin.readAll().findAll(re(r"\d+")).map(parseInt)

let numPlayers = input[0]
let lastMarble = input[1]

var circle = initDoublyLinkedRing[int]()
circle.append(0)

var players = repeat(0, numPlayers)

proc rotateCounter(n: int) =
  for i in 0 ..< n:
    circle.head = circle.head.prev

for i in 1 .. lastMarble:
  if (i mod 23) != 0:
    circle.head = circle.head.next.next
    circle.prepend(i)
  else:
    rotateCounter(6)
    players[i mod numPlayers] += i + circle.head.prev.value
    circle.remove(circle.head.prev)

echo players.max
