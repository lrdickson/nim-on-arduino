proc delay(dwMs: int) {.header: "Arduino.h", importc: "delay".}
proc digitalWrite(dwPin: int, dwVal: int) {.header: "Arduino.h", importc: "digitalWrite".}
proc pinMode(dwPin: int, dwMode: int) {.header: "Arduino.h", importc: "pinMode".}

proc serialBegin(speed: int) {.header: "Serial.h", importc.}
proc serialPrintln(line: cstring) {.header: "Serial.h", importc.}
proc serialReady(): bool {.header: "Serial.h", importc.}
proc serialWrite(text: cstring) {.header: "Serial.h", importc.}
proc serialAvailableForWrite(): int {.header: "Serial.h", importc.}

const HIGH = 0x1
const LOW = 0x0
const INPUT = 0x0
const OUTPUT = 0x1
const LED_BUILTIN = 13

var count = 1

proc blink() =
  digitalWrite(LED_BUILTIN, HIGH)
  delay(500)
  digitalWrite(LED_BUILTIN, LOW)
  delay(500)

proc setup() {.exportc.} =
  pinMode(LED_BUILTIN, OUTPUT)
  serialBegin(115200)

proc loop() {.exportc.} =
  # Begin counting
  if serialReady():
    var countStr = $count
    if countStr.len <= serialAvailableForWrite():
      serialWrite(cstring(countStr & "\n"))
  count += 1

  blink()

