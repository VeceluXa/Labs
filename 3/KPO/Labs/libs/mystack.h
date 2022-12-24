#ifndef MY_STACK
#define MY_STACK

#include "mystring.h"

struct Stack {
    int data;
    struct Stack* next;
};

extern void push(struct Stack** stack, int data);
extern int pop(struct Stack** stack);
extern int peek(struct Stack* stack);
extern char isEmpty(struct Stack* stack);
extern int getSize(struct Stack* stack);

#endif