#include "mystack.h"

void push(struct Stack** stack, int data) {
    // Get node
    struct Stack* nodePrev = *stack;

    struct Stack* nodeNew = (struct Stack*) malloc(sizeof(struct Stack));
    nodeNew->data = data;
    nodeNew->next = nodePrev;

    *stack = nodeNew;
}

int pop(struct Stack** stack) {
    // Get node
    struct Stack* node = *stack;
    int data = node->data;

    // Move stack to next element
    *stack = (*stack)->next;

    // Free space
    free(node);

    return data;
}

int peek(struct Stack* stack) {
    return stack->data;
}

char isEmpty(struct Stack* stack) {
    if (stack == NULL)
        return 1;
    else
        return 0;
}

int getSize(struct Stack* stack) {
    if (isEmpty(stack) == 1) return 0;
    struct Stack* node = stack;
    int size = 1;

    while(node->next != NULL) {
        size++;
        node = node->next;
    }

    return size;
}