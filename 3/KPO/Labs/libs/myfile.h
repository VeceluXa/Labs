#ifndef MY_FILE
#define MY_FILE

#include "mystring.h"
#include <stdio.h>

#define MAX_LINE_LENGTH 80

// Check if file can be opened for certain permission
// If file can be opened, return 1
// Else - return 0
extern char isFileOpen(const char* fileName, const char* permission);

extern char* fileReadLine(FILE* file);

#endif