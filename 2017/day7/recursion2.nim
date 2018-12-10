import re, rdstdin, strutils, sequtils, algorithm

func present(s: string): bool = len(s) > 0
let input = stdin.readAll().splitLines().filter(present)

type
  Tower = ref object of RootObj
    name: string
    weight: int
    children: seq[Tower]

var towers = newSeq[Tower]()

proc findTower(name: string): Tower =
  for tower in towers:
    if tower.name == name: return tower

for line in input:
  let name = line.split(" ")[0]
  let weight = line.findAll(re(r"\d+"))[0].parseInt

  towers.add(Tower(name: name, weight: weight))

for line in input:
  if not line.contains("->"): continue

  let tower = findTower(line.split(" ")[0])
  tower.children = line.split("-> ")[1].findAll(re(r"\w+")).map(findTower)

proc totalWeight(tower: Tower): int =
  if tower.children.len == 0: return tower.weight

  tower.weight + tower.children.map(proc(c: Tower): int = c.totalWeight).foldl(a + b)

proc `$`(tower: Tower): string =
  tower.name & "(" & $tower.totalWeight & ")"

proc imbalanced(tower: Tower): bool =
  tower.children.map(totalWeight).deduplicate.len > 1

for tower in towers:
  if tower.imbalanced and not tower.children.any(imbalanced):
    echo tower.children.mapIt(it.totalWeight)
    echo tower.children.mapIt(it.weight)
