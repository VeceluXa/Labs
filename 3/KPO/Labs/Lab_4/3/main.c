#include "../../libs/mystring.h"

char myComparator(char a, char b) {
    if ((int) a < (int) b) return 1;
    else if ((int) a > (int) b) return -1;
    else return 0;    
}

char* task(char* str) {
    char* strNew = (char*) malloc(1*sizeof(char));
    int j = 0;

    for(int i = 0; str[i] != 0; i++) {
        if ((str[i] >= 'q' && str[i] <= 'z') || (str[i] >= 'Q' && str[i] <= 'Z')) {
            if (str[i] >= 'q' && str[i] <= 'z') 
                strNew[j] = str[i] - ('q' - 'Q');
            else 
                strNew[j] = str[i];
            j++;
            strNew = (char*) realloc(strNew, (j+1)*sizeof(char));
        }
    }
    strNew[j] = 0;

    strSort(strNew, myComparator);

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