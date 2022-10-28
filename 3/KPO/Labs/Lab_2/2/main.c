#include <stdio.h>
#include <stdlib.h>
#include <time.h>

const int ARR_SIZE = 7;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int main() {
    srand(time(NULL));
    int a[ARR_SIZE][ARR_SIZE];

    printf("Input array:\n");
    for (int i = 0; i < ARR_SIZE; i++) {
        for (int j = 0; j < ARR_SIZE; j++) {
            a[i][j] = rand() % 100 + 1;
            printf("%d ", a[i][j]);
        }
        printf("\n");
    }

    for (int i = 0; i < ARR_SIZE; i++) {
        int maxCol = 0;
        for (int j = 1; j < ARR_SIZE; j++) {
            if (a[i][j] > a[i][maxCol]) maxCol = j;
        }
        swap(&a[i][i], &a[i][maxCol]);
    }

    printf("\nMax elements in diag:\n");
    for (int i = 0; i < ARR_SIZE; i++) {
        for (int j = 0; j < ARR_SIZE; j++)
            printf("%d ", a[i][j]);
        printf("\n");
    }
    

    return 0;
}