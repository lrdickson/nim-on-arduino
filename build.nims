import std/os
import std/strformat

# Make the build directory
let buildDir = "build"
rmDir buildDir
mkdir buildDir

# Compile the nim code to C
let arduinoLibraries = buildDir / "libraries"
let libraryName = "Sketch"
let nimOut = arduinoLibraries / libraryName
mkdir nimOut
let nimEntry = "nimsrc" / "sketch.nim"
exec &"nim c -c --gc:arc --cpu:arm --os:any -d:useMalloc --noMain:on -d:release --opt:size --nimcache:{nimOut} {nimEntry}"
let headerName = libraryName & ".h"
let csrcDir = "csrc"
cpFile csrcDir / headerName, nimOut / headerName

# Add C files to complete the library
cpFile "/usr/lib/nim/nimbase.h", nimOut / "nimbase.h"
cpFile csrcDir / "Serial.h", nimOut / "Serial.h"
cpFile csrcDir / "serial.cpp", nimOut / "serial.cpp"

# Setup the sketch for arduino
let sketchDir = buildDir / "sketch"
mkdir sketchDir
let sketchFileName = "sketch.ino"
let sketchFileDest = sketchDir / sketchFileName
cpFile csrcDir / sketchFileName, sketchFileDest

# Use the arduino-cli to compile the C code to a binary
let arduinoOutput = buildDir / "bin"
const board = "Seeeduino:samd:seeed_XIAO_m0"
mkdir arduinoOutput
exec &"arduino-cli compile --libraries {arduinoLibraries} -b {board} --build-path {arduinoOutput} {sketchFileDest}"

# upload
let sketchBin = arduinoOutput / sketchFileName & ".bin"
exec &"arduino-cli upload -b {board} -i {sketchBin} -p /dev/ttyACM0"
