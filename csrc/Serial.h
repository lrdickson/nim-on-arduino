#ifndef Serial_h
#define Serial_h

#ifdef __cplusplus
#define EXTERNC extern "C"
#else
#define EXTERNC
#endif

EXTERNC void serialBegin(int speed);
EXTERNC void serialPrintln(char *line);
EXTERNC bool serialReady();

EXTERNC int serialAvailableForWrite();
EXTERNC void serialWrite(char *str);

#undef EXTERNC

#endif
