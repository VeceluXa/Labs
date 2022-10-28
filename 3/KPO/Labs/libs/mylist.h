#ifndef MY_LIST
#define MY_LIST

#include <stdlib.h>

extern struct Node {
    int data;
    struct Node* next;
};

extern int getLength(struct Node* root);
extern void insert(struct Node* root, int data);
extern void insertPos(struct Node* root, int pos, int data);
extern int get(struct Node* root, int pos);
// extern void removePos(struct Node** root, int pos);
extern void removeRange(struct Node* root, int posIn, int posOut);
extern void removeRange1(struct Node** root, int posIn, int posOut);

#endif