import re, rdstdin, strutils, sequtils, algorithm, tables

func present(s: string): bool = len(s) > 0
let lines = stdin.readAll().splitLines().filter(present).sorted(cmp)

type
  DayData = object of RootObj
    guardId: int
    asleepMinutes: seq[int]

func parseGuardId(line: string): int =
  parseInt(line.findAll(re(r"\d+"), 18)[0])

func parseMin(line: string): int =
  line.findAll(re(r"\d+"))[4].parseInt

func parseHour(line: string): int =
  line.findAll(re(r"\d+"))[3].parseInt

func sleepMins(startMin: int, endMin: int): seq[int] =
  toSeq(startMin..<endMin)

var days = newSeq[DayData]()
var startSleep: int

for line in lines:
  if line.contains("begins shift"):
    days.add(DayData(asleepMinutes: newSeq[int](), guardId: parseGuardId(line)))
  if line.contains("falls asleep"):
    if line.parseHour == 00:
      startSleep = line.parseMin
    else:
      startSleep = 0
  if line.contains("wakes up"):
    if line.parseHour == 00:
      days[days.high].asleepMinutes.insert(sleepMins(startSleep, line.parseMin))
    else:
      days[days.high].asleepMinutes.insert(sleepMins(startSleep, 59))

func guardIds(): seq[int] =
  days.map(func(day: DayData): int = day.guardId).deduplicate

proc task1(): int =
  var minTable = newCountTable[(int, int)]()

  for day in days:
    for minute in day.asleepMinutes:
      minTable.inc((day.guardId, minute))

  minTable.largest[0][0] * minTable.largest[0][1]

proc task2(): int =
  let guardDataMax = guardIds()
    .map(func(guard: int): (int, int, int) =
      let totalMinutes =
        days
          .filter(func(day: DayData): bool = day.guardId == guard)
          .map(func(day: DayData): seq[int] = day.asleepMinutes)
          .foldl(a.concat(b))

      if totalMinutes.len == 0: return

      let highestMinute = totalMinutes
        .deduplicate
        .map(func(min: int): (int, int) = (-totalMinutes.count(min), min))
        .sorted(cmp)[0][1]

      (-totalMinutes.len, guard, highestMinute)
    ).sorted(cmp)[0]

  guardDataMax[1] * guardDataMax[2]

echo task1()
echo task2()
