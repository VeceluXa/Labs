#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void arrGenerate(int** arr, int size) {
    // Generate seed
    srand(time(NULL));
    // Generate array with random numbers
    for (int i = 0; i < size; i++)
        for (int j = 0; j < size; j++)
            arr[i][j] = rand() % 100 + 1;
}

void arrOutput(int** arr, int size) {
    printf("\nArray:\n");
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%3.d", arr[i][j]);
        }
        printf("\n");
    }
}

int task1(int** arr, int size) {
    int min = __INT_MAX__;
    for (int i = 0; i < size/2; i++) {
        for (int j = i+1; j < size-i-1; j++) {
            if (arr[i][j] < min) min = arr[i][j];
            // printf("%d ", arr[i][j]);
        }
    }

    for (int i = size-1; i > size/2; i--) {
        for (int j = size-i; j < i; j++) {
            if (arr[i][j] < min) min = arr[i][j];
            // printf("%d ", arr[i][j]);
        }
    }
    
    return min;
}

int task2(int** arr, int size) {
    int min = __INT_MAX__;

    for (int j = 0; j < size/2; j++) {
        for (int i = j+1; i < size-j-1; i++) {
            if (arr[i][j] < min) min = arr[i][j];
            // printf("%d ", arr[i][j]);
        }
    }

    return min;
}

int main() {
    // Scan size of matrix
    printf("Enter even size of matrix:\n");
    int size;
    char isRead = 0;
    while(!isRead) {
        scanf("%d", &size);
        printf("\n");
        if(size % 2 == 1) isRead = 1;
    }

    // Allocate memory
    int** arr = (int**)malloc(size * size * sizeof(int));
    for (int i = 0; i < size; i++)
        arr[i] = (int*)malloc(size * sizeof(int));
        
    arrGenerate(arr, size);
    arrOutput(arr, size);


    printf("\nResult:\n%d\n%d", task1(arr, size), task2(arr, size));


    return 0;
}