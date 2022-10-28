#include "mystring.h"

char* lineRead() {
    char* str = (char*) malloc(1*sizeof(char));
    int strLen = 1;
    char ch;
    int i = 0;
    // while((ch = fgetc(stdin)) != '\n' && ch != EOF);
    while(ch = fgetc(stdin), ch != '\n') {
        str[i] = ch;
        i++;
        str = (char*) realloc(str, (i+1)*sizeof(char));
    }
    str[i] = 0;
    return str;
}

char* lineFileRead(FILE* file) {
    char* str = (char*) malloc(1*sizeof(char));
    int strLen = 1;
    char ch;
    int i = 0;
    // while((ch = fgetc(stdin)) != '\n' && ch != EOF);
    while(ch = fgetc(file), ch != '\n' && ch != EOF) {
        str[i] = ch;
        i++;
        str = (char*) realloc(str, (i+1)*sizeof(char));
    }
    str[i] = 0;
    return str;
}

char* inputString(FILE *fp, size_t size) {
    char* str;
    int ch;
    size_t len = 0;
    str = (char*)realloc(NULL, sizeof(*str)*size);
    if(!str) return str;
    while(EOF!=(ch=fgetc(fp)) && ch != '\n') {
        str[len++] = ch;
        if(len==size) {
            str = (char*)realloc(str, sizeof(*str)*(size+=16));
            if(!str) return str;
        }
    }

    str[len++]='\0';

    return (char*)realloc(str, sizeof(*str)*len);
}

void linePrint(char* str) {
    int i = 0;
    while(str[i] != 0) {
        printf("%c", str[i]);
        i++;
    }
    printf("\n");
}

void stringPrint(char* str) {
    int i = 0;
    while(str[i] != 0) {
        printf("%c", str[i]);
        i++;
    }
}

int getLen(char* str) {
    int len = 0;
    for(int i = 0; str[i] != 0; i++) {
        len++;
    }
    return len;
}

void linePrintReverse(char* str) {
    for (int i = getLen(str); i >= 0; i--)
        printf("%c", str[i]);
    printf("\n");
}

char* lineGetReverse(char* str) {
    char* strNew = (char*) malloc(getLen(str)*sizeof(char));
    for (int i = getLen(str)-1, j = 0; i >= 0; i--, j++)
        strNew[j] = str[i];
    strNew[getLen(str)+1] = 0;
    return strNew;
}

void strSort(char* str, char (*comparator)(char a, char b)) {

    for(int i = 0; str[i+1] != 0; i++) {
        char minCharInd = i;
        for(int j = i + 1; str[j] != 0; j++) {
            if(comparator(str[j], str[minCharInd]) > 0) minCharInd = j;
        }

        if (minCharInd != i) {
            char temp = str[i];
            str[i] = str[minCharInd];
            str[minCharInd] = temp;
        }
        
    }
}

char* strCat(int num, ...) {
    va_list valist;
    char* result = (char*) malloc(1*sizeof(char));

    char* str;
    va_start(valist, num);

    int resInd = 0;
    int resSize = 1*sizeof(char);
    for (int i = 0; i < num; i++) {
        str = va_arg(valist, char*);
        resSize + getLen(str)*sizeof(char);
        result = (char*)realloc(result, resSize);
        for (int j = 0; str[j] != 0; j++) {
            result[resInd] = str[j];
            resInd++;
        }
    }
    result[resInd] = 0;
    
    va_end(valist);
    return result;
}

char** strDiv(char* str, char div) {
    char** result = (char**) malloc(2*sizeof(char*));
    result[0] = (char*) malloc(1*sizeof(char));
    int rowInd = 0, colInd = 0;
    for (int i = 0; str[i] != 0; i++) {
        if(str[i] == div) {
            result[rowInd][colInd] = 0;
            rowInd++;
            colInd = 0;
            result = (char**) realloc(result, (rowInd+1)*sizeof(char*));
            result[rowInd] = (char*) realloc(result[rowInd], 1*sizeof(char));
        } else {
            result[rowInd][colInd] = str[i];
            colInd++;
            result[rowInd] = (char*) realloc(result[rowInd], (colInd+2)*sizeof(char));
        }
    }

    result[rowInd][colInd] = 0;
    result[rowInd+1] = NULL;
    
    return result;
}

char compStr(char* str1, char* str2) {
    
    char isCompared = 0;
    char ch1 = str1[0];
    char ch2 = str2[0];
    int i = 0;
    while (ch1 != 0 || ch2 != 0) {
        if (ch1 != 0 && ch2 != 0) {
            if (ch1 < ch2) {
                return 1;
            } else if (ch2 < ch1) {
                return -1;
            } else { 
                i++;
                ch1 = str1[i];
                ch2 = str2[i];
            }
            
        } else {

            // if ch1 == NULL return 1 (str1 < str2)
            // if ch2 == NULL return -1 (str2 < str1)
            if (ch1 == 0) {
                return 1;
            } else {
                return -1;
            }
            
        }
    }
    
    return 0;
}