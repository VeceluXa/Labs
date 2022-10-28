//13
#include <stdio.h>
#include <stdlib.h>
#include "../libs/mystring.h"

struct item{
    char* name;
    size_t price;
    size_t count;
};


void itemInput(struct item* items, size_t size) {
    size_t c;
    while((c = fgetc(stdin)) != '\n' && c != EOF);
    for (size_t i = 0; i < size; i++) {
        printf("Read item[%d] name: ", i);
        char* name = lineRead();
        items[i].name = name;
        printf("Read item[%d] price: ", i);
        scanf("%d", &items[i].price);
        while((c = fgetc(stdin)) != '\n' && c != EOF);
        printf("Read item[%d] count: ", i);
        scanf("%d", &items[i].count);
        while((c = fgetc(stdin)) != '\n' && c != EOF);
    }
}

void itemOutput(struct item* item, size_t size) {
    for (int i = 0; i < size; i++) {
        printf("%d. ", i+1);
        stringPrint(item[i].name);
        printf(" $%d %d\n", item[i].price, item[i].count);
    }
}

struct item* itemSort(struct item *itemOriginal, size_t size) {
    struct item* items = (struct item*)malloc(
        size*sizeof(struct item));

    for (size_t i = 0; i < size; i++) {
        items[i] = itemOriginal[i];
    }
    

    for (size_t i = 0; i < size-1; i++) {
        size_t minId = i;
        for (size_t j = i+1; j < size; j++) {
            if (items[j].price < items[minId].price) 
                minId = j;
        }

        struct item temp = items[i];
        items[i] = items[minId];
        items[minId] = temp;
    }
    
    return items;
}

int main() {
    
    int n;
    printf("Enter number of records:\n");
    scanf("%d", &n);
    printf("\n");

    struct item* items = (struct item*)malloc(
        n*sizeof(struct item));

    // Read string
    itemInput(items, n);

    // Output items
    printf("\nOriginal array:\n");
    itemOutput(items, n);

    // Sort items
    struct item* itemsSorted = itemSort(items, n);

    // Output items
    printf("\nSorted array:\n");
    itemOutput(itemsSorted, n);
}