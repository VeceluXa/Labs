#include "../../libs/mystring.h"

int getSpaces(char* str) {
    int spaces = 0;
    for(int i = 0; str[i] != 0; i++) {
        if(str[i] == ' ') spaces++;
    }
    return spaces;
}

int main() {
    
    // Read string
    char* str = lineRead();
    

    // Print str
    printf("\nEntered line:\n");
    linePrint(str);

    // Get length
    printf("\nLength of line:\n%d\n", getLen(str));

    // Get spaces
    printf("\nNumber of spaces:\n%d\n", getSpaces(str));

    // Print reversed line
    printf("\nReversed line:\n");
    linePrintReverse(str);

    return 0;
}