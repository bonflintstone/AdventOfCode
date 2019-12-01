import rdstdin, sequtils, strutils, re

let input = stdin.readAll().findAll(re(r"\d+")).map(parseInt)

func get_fuel(mass: int): int =
  int(float(mass) / 3.0) - 2

func get_fuel(masses: seq[int]): int =
  masses.map(get_fuel).foldl(a + b)

func get_all_fuel(mass: int): int =
  let new_fuel = get_fuel(mass)

  if new_fuel > 0:
    return get_all_fuel(new_fuel) + new_fuel
  else:
    return 0

func get_all_fuel(masses: seq[int]): int =
  masses.map(get_all_fuel).foldl(a + b)

echo get_fuel(input)
echo get_all_fuel(input)
