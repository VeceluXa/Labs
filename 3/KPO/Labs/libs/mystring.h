#ifndef MY_STRING
#define MY_STRING

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

// Read line
extern char* lineRead();

// Read line from file
char* lineFileRead(FILE* file);

// Input string
extern char* inputString(FILE *fp, size_t size);

// Print line
extern void linePrint(char* str);

// Print string
extern void stringPrint(char* str);

// Get length of string
extern int getLen(char* str);

// Print reversed string
extern void linePrintReverse(char* str);

// Get pointer to reversed string
extern char* lineGetReverse(char* str);

// Sort string alphabetically 
extern void strSort(char* str, char (*comparator)(char a, char b));

// Concate multiple strings
extern char* strCat(int num, ...);

// Divide string in array by divisor
extern char** strDiv(char* str, char div);

// Compare 2 strings
// Return 1 if str1 < str2
// Return -1 if str2 < str1
// Return 0 if str1 == str2
extern char compStr(char* str1, char* str2);

#endif