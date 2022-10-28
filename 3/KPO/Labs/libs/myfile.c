#include "myfile.h"

char isFileOpen(const char* fileName, const char* permission) {
    if (permission == "r" || permission == "rb" || permission == "w" ||
        permission == "wb" || permission == "a" || permission == "ab" ||
        permission == "r+" || permission == "rb+" || permission == "w+" ||
        permission == "wb+" || permission == "a+" || permission == "ab+") {
        FILE *file;
        if (file = fopen(fileName, permission)) {
            fclose(file);
            return 1;
        }
    }
    return 0;
}

char* fileReadLine(FILE* file) {
    if (!file) {
        return NULL;
    }

    char* str = (char*) malloc(1*sizeof(char));
    int strLen = 1;
    char ch;
    int i = 0;
    while(ch = fgetc(file), ch != '\n') {
        str[i] = ch;
        i++;
        str = (char*) realloc(str, (i+1)*sizeof(char));
    }
    str[i] = 0;
    return str;
}