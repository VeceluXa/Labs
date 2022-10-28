#include <stdio.h>
#include <stdlib.h>
#include <time.h>

const int ARR_SIZE = 6;

struct pair {
    int val;
    int count;
};

char contains(struct pair a[], int b) {
    for (int i = 0; i < 36; i++)
        if (a[i].val == b) return 1;
    return 0;
}

int main() {
    srand(time(NULL));
    int a[6][6];
    struct pair b[36];

    // Initialize array b with 0s
    for (int i = 0; i < 36; i++) b[i].val = 0;
    
    // Input array and output it
    printf("Input array:\n");
    for (int i = 0; i < ARR_SIZE; i++) {
        for (int j = 0; j < ARR_SIZE; j++) {
            a[i][j] = rand() % 20 + 2;
            printf("%d ", a[i][j]);
        }
        printf("\n");
    }
    
    // Calculate unique values
    int k = 0;
    for (int i = 0; i < ARR_SIZE; i++) 
        for (int j = 0; j < ARR_SIZE; j++)
            for (int k = 0; k < ARR_SIZE; k++) {
                if (a[i][j] == b[k].val) b[k].count++; else b[k].val = a[i][j];
            }

    printf("\nUnique values:\n");
    for (int i = 0; i < 36; i++) printf("%d ", b[i]);
    

    for (int i = 0; i < ARR_SIZE; i++) 
        for (int j = 0; j < ARR_SIZE; j++) 
            for (int k = 0; k < 36; k++)
                if (b[k].val == a[i][j] && b[k].count > 1) a[i][j] = 1; else a[i][j] = 0;

    printf("\nArray after changes:\n");
    for (int i = 0; i < ARR_SIZE; i++) {
        for (int j = 0; j < ARR_SIZE; j++)
            printf("%d ", a[i][j]);
        printf("\n");
    }
    

    return 0;
}