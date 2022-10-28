#include <stdio.h>
#include "../libs/mystring.h"
// #include <string.h>

// #include <unistd.h>
// #include <limits.h>

char doContinue() {
    printf("Do you wish to continue? Y/N (default Yes)\n> ");
    char ch;
    scanf("%c", &ch);
    if (ch == 'N' || ch == 'n') {
        return 0;
    } else {
        return 1;
    }
}

void writeString(char* str, FILE* file) {
    for (size_t i = 0; i < getLen(str); i++) {
        fputc(str[i], file);
    }
    fputc('\n', file);
}

char mergeStringFile() {
    char ch;
    system("clear");
    printf("Merge 2 files:\n");
    // printf("Read name of first file:\n> ");
    // while((ch = fgetc(stdin)) != '\n' && ch != EOF);
    // char* fileName1 = lineRead();
    // printf("Read name of second file:\n> ");
    // char* fileName2 = lineRead();
    // printf("Read name of result file:\n> ");
    // char* fileNameResult = lineRead();

    // FILE *file1 = fopen(fileName1, "r");
    FILE *file1 = fopen("/home/danilovfa/BSUIR/3/KPO/Labs/Lab_7/1/1.txt", "r");
    // printf("%p\n", (void *)file1);
    // scanf("%c", &ch);
    FILE *file2 = fopen("/home/danilovfa/BSUIR/3/KPO/Labs/Lab_7/1/2.txt", "r");
    FILE *fileResult = fopen("/home/danilovfa/BSUIR/3/KPO/Labs/Lab_7/1/res.txt", "w");
    // FILE *file2 = fopen(fileName2, "r");
    // FILE *fileResult = fopen(fileNameResult, "w");


    if (file1 == NULL || file2 == NULL || fileResult == NULL) {
        printf("Could not open a file.\n");
        return doContinue();
    }

    system("sort -o /home/danilovfa/BSUIR/3/KPO/Labs/Lab_7/1/1.txt /home/danilovfa/BSUIR/3/KPO/Labs/Lab_7/1/1.txt");
    system("sort -o /home/danilovfa/BSUIR/3/KPO/Labs/Lab_7/1/2.txt /home/danilovfa/BSUIR/3/KPO/Labs/Lab_7/1/2.txt");
    
    while((ch = fgetc(stdin)) != '\n' && ch != EOF);
    char* str1 = lineFileRead(file1);
    char* str2 = lineFileRead(file2);

    while (str1[0] != 0 || str2[0] != 0) {
        if (str1[0] != 0 && str2[0] != 0) {
            if (compStr(str1, str2) == 1) {
                writeString(str1, fileResult);
                str1 = lineFileRead(file1);
            } else {
                writeString(str2, fileResult);
                str2 = lineFileRead(file2);
            }
        } else {
            if (str1[0] == 0) {
                writeString(str2, fileResult);
                str2 = lineFileRead(file2);
            } else {
                writeString(str1, fileResult);
                str1 = lineFileRead(file1);
            }
        }
    }
    
    fclose(file1);
    fclose(file2);
    fclose(fileResult);

    // printf("Sucessuly merged %s and %s into %s\n", fileName1, fileName2, fileNameResult);

    return doContinue();
}

char mergeIntFile() {
    char ch;
    system("clear");
    printf("Merge 2 sorted files:\n");
    printf("Read name of first file:\n> ");
    while((ch = fgetc(stdin)) != '\n' && ch != EOF);
    char* fileName1 = lineRead();
    printf("Read name of second file:\n> ");
    char* fileName2 = lineRead();
    printf("Read name of result file:\n> ");
    char* fileNameResult = lineRead();

    FILE *file1 = fopen(fileName1, "r");
    FILE *file2 = fopen(fileName2, "r");
    FILE *fileResult = fopen(fileNameResult, "w");

    if (file1 == NULL || file2 == NULL || fileResult == NULL) {
        printf("Could not open a file.\n");
        return doContinue();
    }

    char ch1 = getc(file1);
    char ch2 = getc(file2);
    while (ch1 != EOF || ch2 != EOF) {
        if (ch1 != EOF && ch2 != EOF) {
            if (ch1 > ch2) {
                fputc(ch1, fileResult);
                ch1 = fgetc(file1);
            } else {
                fputc(ch2, fileResult);
                ch2 = fgetc(file2);
            }
        } else {
            if (ch1 == EOF) {
                fputc(ch2, fileResult);
                ch2 = fgetc(file2);
            } else {
                fputc(ch1, fileResult);
                ch1 = fgetc(file1);
            }
        }
    }

    fclose(file1);
    fclose(file2);
    fclose(fileResult);
    
    printf("Sucessuly merged %s and %s into %s\n", fileName1, fileName2, fileNameResult);

    return doContinue();
}
// #define PATH_MAX 100
int main() {
//     char cwd[PATH_MAX];
//    if (getcwd(cwd, sizeof(cwd)) != NULL) {
//        printf("Current working dir: %s\n", cwd);
//    } else {
//        perror("getcwd() error");
//        return 1;
//    }

    int i = 0;
    char isContinue = 1;
    while(isContinue) {
        system("clear");
        printf("Choose what to do:\n");
        printf("1. Merge 2 lists alphabetically;\n");
        printf("2. Merge 2 sorted files;\n");
        printf("3. Exit.\n");
        fflush(stdin);
        scanf("%d", &i); 
        switch (i) {
            case 1: {
                isContinue = mergeStringFile();
                break;
            }
            case 2: {
                isContinue = mergeIntFile();
                break;
            }

            default: {
                isContinue = 0;
                break;
            }
        }
    }

    return 0;
}