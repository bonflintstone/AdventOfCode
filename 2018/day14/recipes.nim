import strutils, sequtils, lists, algorithm

var recipes: DoublyLinkedRing[int]
recipes.append(3)
recipes.append(7)

var elf1 = recipes.head
var elf2 = recipes.head.next

const goal = @[8, 4, 6, 6, 0, 1]

proc isFound(): bool =
  var currentChecked = recipes.head.prev
  for f in goal.reversed:
    if f != currentChecked.value: return false
    currentChecked = currentChecked.prev
  true

var count = 2
while not isFound():
  var recipe = elf1.value + elf2.value

  if recipe > 9:
    recipes.append 1
    inc count
    if isFound(): break
    recipes.append(recipe - 10)
  else:
    recipes.append recipe

  inc count

  for i in 0 ..< (elf1.value + 1):
    elf1 = elf1.next
  for i in 0 ..< (elf2.value + 1):
    elf2 = elf2.next

echo count - goal.len
