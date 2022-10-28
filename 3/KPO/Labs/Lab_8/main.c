#include <stdio.h>
#include "../libs/mylist.h"

void task() {
    struct Node* list;
    list = malloc(sizeof(struct Node));
    list->data = 20;

    insert(list, 15);
    insert(list, 32);
    insert(list, 5);
    insert(list, -12);
    insert(list, 11);
    insert(list, 5);
    insert(list, 55);
    insert(list, -1);
    insert(list, 10);

    int minPos = 0;
    int maxPos = 0;
    for (int i = 1; i < getLength(list); i++) {
        if (get(list, i) < get(list, minPos)) 
            minPos = i;
        
        if (get(list, i) > get(list, maxPos)) 
            maxPos = i;
    }

    if (minPos < maxPos) {
        removeRange(list, minPos, maxPos);
    } else {
        removeRange(list, maxPos, minPos);
    }

     if (getLength(list) == 0) {
        printf("Removed all elements");
        return;
    }
    
    for (int i = 0; i < getLength(list); i++) {
        int data = get(list, i);
        printf("%d ", data);
    }
}

int main() {
    task();
    return 0;
}