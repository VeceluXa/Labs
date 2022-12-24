#include <stdio.h>
#include "/home/danilovfa/BSUIR/Labs/3/KPO/Labs/libs/mystring.h"

#define STRING_LEN      100
#define STATEMENT_NUM   3
#define CHAR_TYPE       3

#define  IS_BINARY(a) ((a) == '0' || (a) == '1')
#define  IS_OCTAL(a) ((a) >= '0' && (a) <= '7')
#define IS_HEX(a) ((a) >= '0' && (a) <= '9' || (a) >= 'A' && (a) <= 'Z')
#define IS_LETTER(a) ((a) == 'B' || (a) == 'O' || (a) == 'H')

typedef enum State {
    digit = 0, unknown = 1
} statement;

typedef enum Boolean {
    true = 1, false = 0
} bool;

statement getCharTypeBinary(char c) {
    statement result = unknown;
    if (IS_BINARY(c))
        result = digit;
    return result;
}

statement getCharTypeOctal(char c) {
    statement result = unknown;
    if (IS_OCTAL(c))
        result = digit;
    return result;
}

statement getCharTypeHex(char c) {
    statement result = unknown;
    if (IS_HEX(c))
        result = digit;
    return result;
}

bool getCorrectIdentificator(char* s) {

    int stateTable[STATEMENT_NUM][CHAR_TYPE] = {
            //    alpha digit error
            {0,0},  //zero
            {2,0},  //A
            {2,2}   //Quit

    };
    statement state;
    int stateNum = 1;

    for (int i = 0; (stateNum) && (s[i]); i++) {
        state = getCharType(s[i]);
        stateNum = stateTable[stateNum][state];
    }

    if (stateNum)
        return true;
    else
        return false;
}

char isBinary(char* str) {
    int length = getLen(str);
    if (str[length - 1] != 'B') {
        return 0;
    }

    str[length - 1] = 0;

    for (int i = 0; str[i] != 0; i++) {
        if (str[i] != '0' && str[i] != '1')
            return 0;
    }
    
    return 1;
}


char isOctal(char* str) {
    int length = getLen(str);
    if (str[length - 1] != 'O') {
        return 0;
    }

    str[length - 1] = 0;

    for (int i = 0; str[i] != 0; i++) {
        if (!(str[i] >= '0' && str[i] <= '7'))
            return 0;
    }
    
    return 2;
}

char isHex(char* str) {
    int length = getLen(str);
    if (str[length - 1] != 'H') {
        return 0;
    }

    if (!(str[0] >= '0' && str[0] <= '9'))
        return 0;

    str = &str[1];

    str[length - 2] = 0;

    for (int i = 0; str[i] != 0; i++) {
        if (!((str[i] >= '0' && str[i] <= '9') || (str[i] >= 'A' && str[i] <= 'F')))
            return 0;
    }
    
    return 3;
}

void toUpperCase(char** strInp) {
    char* str = *strInp;
    for (int i = 0; str[i] != 0; i++) {
        if (str[i] >= 'a' && str[i] <= 'z') {
            str[i] -= 'a' - 'A';
        }
    }
}

char isNumber(char* strInp) {

    toUpperCase(&strInp);
    linePrint(strInp);
    return isBinary(strInp) + isOctal(strInp) + isHex(strInp);
}

int main(int argc, char* argv[]) {
    char state;
    if (argc == 2) {
        state = isNumber(argv[1]);
    } else {
        printf("Print a number:\n");
        char* str = lineRead();
        state = isNumber(str);
    }

    if (state == 1) {
        printf("It's a binary number.\n");
    } else if (state == 2) {
        printf("It's an octadecimal number.\n");
    } else if (state == 3) {
        printf("It's a hexadecimal number.\n");
    } else {
        printf("It's not a number.\n");
    }
    
    return 0;
}