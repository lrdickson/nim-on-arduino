#include "Arduino.h"
#include "Serial.h"

extern "C" void serialBegin(int speed) {
	Serial.begin(speed);
}

extern "C" void serialPrintln(char *line) {
	Serial.println(line);
}

extern "C" void serialWrite(char *str) {
	Serial.write(str);
}

extern "C" int serialAvailableForWrite() {
	return Serial.availableForWrite();
}

extern "C" bool serialReady() {
	if (Serial)
		return true;
	else
		return false;
}

