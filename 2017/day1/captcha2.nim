import os
import strutils

if paramCount() != 1:
  echo "Invalid arg count"
  system.quit()

let digits = paramStr(1)
var sum = 0

proc next(i: int): int =
  (i + (digits.len div 2)) mod digits.len

for i, digit in digits:
  if digit == digits[i.next]:
    sum = sum + int(digit) - int('0')

echo sum
