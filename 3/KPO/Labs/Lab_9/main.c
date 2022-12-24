#include "../libs/mystack.h"

void pushSorted(struct Stack** stack, int data) {
    struct Stack* stackSorted = (struct Stack*) malloc(sizeof(struct Stack));
    struct Stack* stackOld = *stack;

    *stack = stackSorted;
}

// Recursive function to insert an item x in sorted way
void sortedInsert(struct Stack** stack, int x)
{
    // Base case: Either stack is empty or newly inserted
    // item is greater than top (more than all existing)
    if (isEmpty(*stack) || x <= peek(*stack)) {
        push(stack, x);
        return;
    }
 
    // If top is greater, remove the top item and recur
    int temp = pop(stack);
    sortedInsert(stack, x);
 
    // Put back the top item removed earlier
    push(stack, temp);
}
 
// Function to sort stack
void sortStack(struct Stack** stack)
{
    // If stack is not empty
    if (!isEmpty(*stack)) {
        // Remove the top item
        int x = pop(stack);
 
        // Sort remaining stack
        sortStack(stack);
 
        // Push the top item back in sorted stack
        sortedInsert(stack, x);
    }
}

int main() {
    struct Stack* stack;

    push(&stack, 1);
    push(&stack, 2);
    push(&stack, 3);
    push(&stack, 4);
    push(&stack, 5);
    push(&stack, 6);
    push(&stack, 32);
    push(&stack, 12);


    push(&stack, 12);
    push(&stack, 5);
    push(&stack, 3);
    push(&stack, 2);






    push(&stack, 500);
    sortStack(&stack);

    while (stack->next != NULL) {
        printf("%d ", pop(&stack));
    }

    return 0;
}

