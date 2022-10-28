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

int sumRow(int* arr, int size) {
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += arr[i];
    }
    
    return sum;
}

void arrOutput(int** arr, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%3.d", arr[i][j]);
        }
        printf(" = %3.d", sumRow(arr[i], size));
        printf("\n");
    }
}

void swapRows(int **array, int row1, int row2) {
    int *temp = array[row1];
    array[row1] = array[row2];
    array[row2] = temp;
}

void arrSort(int** arr, int size) {
    for (int i = 0; i < size-1; i++) {
        int minInd = i;
        for (int j = i+1; j < size; j++) {
            if (sumRow(arr[j], size) < sumRow(arr[minInd], size)) minInd = j;
        }
        if(minInd != i) swapRows(arr, minInd, i);
    }
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
    
    printf("Original array:\n");
    arrOutput(arr, size);

    arrSort(arr, size);

    printf("\nSorted array:\n");
    arrOutput(arr, size);

    return 0;
}