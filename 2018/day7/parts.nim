import re, rdstdin, strutils, sequtils, algorithm

func present(s: string): bool = len(s) > 0
let lines = stdin.readAll().splitLines().filter(present).sorted(cmp)

const workerCount = 5

var parts = newSeq[string]()
var run = newSeq[string]()

proc calcConstraints(): seq[seq[string]] =
  result = newSeq[seq[string]]()
  
  for line in lines:
    let tmp = line.findAll(re(r"\b[A-Z]\b"))

    result.add(tmp)

    if not parts.contains(tmp[0]): parts.add(tmp[0])
    if not parts.contains(tmp[1]): parts.add(tmp[1])

  parts.sort(cmp)

let constraints = calcConstraints()

proc canRun(s: string): bool =
  constraints.all(proc(c: seq[string]): bool =
    c[1] != s or run.contains(c[0])
  )

var workingOn = newSeq[string]()
var timeRemaining = newSeq[int]()

for i in (0..<workerCount):
  workingOn.add("")
  timeRemaining.add(0)

var count = -1

while true:
  if run.len == parts.len: break
  inc count

  for i in (0..<workerCount):
    if timeRemaining[i] == 0 and workingOn[i] != "":
      run.add(workingOn[i])
      workingOn[i] = ""

  let runnables = parts
    .filter(proc(s: string): bool = not (run.contains(s) or workingOn.contains(s)))
    .filter(canRun)
    .sorted(cmp)

  for i in (0..<workerCount):
    timeRemaining[i] = max(0, timeRemaining[i] - 1)

  for runnable in runnables:
    for i in (0..<workerCount):
      if workingOn[i] != "":
        continue

      workingOn[i] = runnable
      timeRemaining[i] = ord(runnable[0]) - ord('A') + 60
      break

  echo $count & " " & $workingOn

echo count
