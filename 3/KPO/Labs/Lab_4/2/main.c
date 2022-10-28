#include "../../libs/mystring.h"

char* task(char* str) {
    char* strNew = (char*) malloc(getLen(str)*sizeof(char));

    char* digits = (char*) malloc(1*sizeof(char));
    char* letters = (char*) malloc(1*sizeof(char));

    int digitsInd = 0, lettersInd = 0;
    for(int i = 0; str[i] != 0; i++) {
        // Get digit
        if (str[i] >= '0' && str[i] <= '9') {
            digits[digitsInd] = str[i];
            digitsInd++;       
            digits = (char*) realloc(digits, (digitsInd)*sizeof(char));
        }
        // Get letter
        if ((str[i] >= 'a' && str[i] <= 'z') || (str[i] >= 'A' && str[i] <= 'Z')) {
            letters[lettersInd] = str[i];
            lettersInd++;       
            letters = (char*) realloc(letters, (lettersInd)*sizeof(char));
        }
    }
    digits[digitsInd] = 0;
    letters[lettersInd] = 0;

    // Reverse digits
    letters = lineGetReverse(letters);
    int savedInd = 0;
    for (int i = 0; letters[i] != 0; i++) {
        strNew[i] = letters[i];
        savedInd = i + 1;
    }

    for (int i = 0; digits[i] != 0; i++) {
        strNew[savedInd] = digits[i];
        savedInd++;
    }
    strNew[getLen(str)+1] = 0;

    return strNew;
}

int main() {
    
    // Read string
    char* str = lineRead();

    // Print str
    printf("\nEntered line:\n");
    linePrint(str);

    printf("\nLine after task completion:\n");
    str = task(str);
    linePrint(str);

    return 0;
}