#include "mylist.h"

int getLength(struct Node* root) {
    if (root == NULL) return 0;
    struct Node* nodeTemp = root;
    int length = 1;

    while(nodeTemp->next != NULL) {
        nodeTemp = nodeTemp->next;
        length++;
    }

    return length;
}

void insert(struct Node* root, int data) {
    if (root == NULL) {
        root = malloc(sizeof(struct Node));
        root->data = data;
        return;
    }
    
    struct Node* nodeNew = malloc(sizeof(struct Node));
    nodeNew->data = data;
    nodeNew->next = NULL;

    struct Node* nodeTemp = root;

    while(nodeTemp->next != NULL) 
        nodeTemp = nodeTemp->next;

    nodeTemp->next = nodeNew;
}

void insertPos(struct Node* root, int pos, int data) {

}

int get(struct Node* root, int pos) {
    struct Node* nodeTemp = root;

    for(int i = 1; i <= pos && nodeTemp->next != NULL; i++) {
        nodeTemp = nodeTemp->next;
    }
    
    return nodeTemp->data;
}

int last(struct Node* root) {
    struct Node* nodeTemp = root;
    while(nodeTemp->next != NULL)   
        nodeTemp = nodeTemp->next;

    return nodeTemp->data;
}

int first(struct Node* root) {
    return root->data;
}

// void removePos(struct Node** root, int pos) {
//     if (pos == 0) {
//         *root = (Node*)root->next;
//     }
    
//     struct Node* nodeTemp = *root;

//     for(int i = 1; i < pos && nodeTemp->next != NULL; i++) {
//         nodeTemp = nodeTemp->next;
//     }
    
//     struct Node* nodePrev = nodeTemp;
//     nodeTemp = nodeTemp->next;
//     struct Node* nodeNext = nodeTemp->next;
//     nodePrev->next = nodeNext;

//     free(nodeTemp);
// }

void removeRange1(struct Node** root, int posIn, int posOut) {
    struct Node* nodeTemp = *root;

    for(int i = 0; i < posIn && nodeTemp->next != NULL; i++) {
        nodeTemp = nodeTemp->next;
    }

    struct Node* nodeInPrev = nodeTemp;
    struct Node* nodeRemoveTemp = nodeTemp;

    // nodeTemp = nodeTemp->next;
    // struct Node* nodeRemoveTemp = nodeTemp;
    
    for(int i = posIn+1; i < posOut && nodeTemp->next != NULL; i++) {
        nodeTemp = nodeTemp->next;
        free(nodeRemoveTemp);
        nodeRemoveTemp = nodeTemp;
    }

    struct Node* nodeOutNext;
    if (nodeTemp->next == NULL) {
        nodeOutNext = NULL;
    } else {
        nodeOutNext = nodeTemp->next;
    }
    
    free(nodeTemp);
    
    if (posIn == 0) {
        *root = nodeOutNext;
        return;
    }
}

void removeRange(struct Node* root, int posIn, int posOut) {
    struct Node* nodeTemp = root;

    for(int i = 1; i < posIn && nodeTemp->next != NULL; i++) {
        nodeTemp = nodeTemp->next;
    }

    struct Node* nodeInPrev = nodeTemp;

    nodeTemp = nodeTemp->next;
    struct Node* nodeRemoveTemp = nodeTemp;
    
    for(int i = posIn; i < posOut && nodeTemp->next != NULL; i++) {
        nodeTemp = nodeTemp->next;
        free(nodeRemoveTemp);
        nodeRemoveTemp = nodeTemp;
    }

    struct Node* nodeOutNext = nodeTemp->next;
    free(nodeTemp);

    nodeInPrev->next = nodeOutNext;
}