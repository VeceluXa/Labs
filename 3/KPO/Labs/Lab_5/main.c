// Var 11
#include "../libs/mystring.h"

void swap(char *x, char *y) { 
    if (x == y) return;
    char temp = *x;
    *x = *y; 
    *y = temp; 
} 

void permute(char* a, int l, int r, char** str, int strSize) { 
    int i; 
    if (l == r) {
        for (int i = 0; i < strSize; i++) {
            stringPrint(str[a[i]-'0']);
            if (i!=strSize-1) printf("_"); 
        }
        printf("\n");
    }
    else { 
        for (i = l; i <= r; i++) { 
            swap(&a[l], &a[i]);  
            permute(a, l+1, r, str, strSize); 
            swap(&a[l], &a[i]);  //backtrack 
        } 
    } 
} 

int main() {

    char* strInp = lineRead();
    char** words = strDiv(strInp, '_');
    int length = 0;
    for (int i = 0; words[i] != NULL; i++) {
        length++;
    }
    
    char* ids = (char*)malloc(length*sizeof(char));
    for (int i = 0; i < length; i++) {
        ids[i] = (char)(i+(int)'0');
    }
    permute(ids, 0, length-1, words, length);
    
    return 0;
}