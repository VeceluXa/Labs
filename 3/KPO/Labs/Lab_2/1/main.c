#include <stdio.h>
#include <stdlib.h>
#include <time.h>

const int ARR_SIZE = 7;

int main() {
    srand(time(NULL));

    int a[ARR_SIZE][ARR_SIZE];
    int b[ARR_SIZE];

    printf("Input array:\n");
    for (int i = 0; i < ARR_SIZE; i++) {
        for (int j = 0; j < ARR_SIZE; j++) {
            a[i][j] = rand() % 100 + 1;
            printf("%d ", a[i][j]);
        }
        printf("\n");
    }

    
    
    for (int i = 0; i < ARR_SIZE; i++) {
        int max = a[i][0];
        for (int j = 1; j < ARR_SIZE; j++) {
            if (a[i][j] > max) max = a[i][j];
        }
        b[i] = max;
    }
    
    printf("\nMax element of each row:\n");
    for (int i = 0; i < ARR_SIZE; i++) 
        printf("%d ", b[i]);

    return 0;
}