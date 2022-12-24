#include "../libs/mytree.h"
#include "../libs/mystring.h"

#include <stdio.h>
#include <stdlib.h>

int getNodeCountRec(struct Tree* tree, int level, int depth) {
    if (tree == NULL) return 0;
    int ans = 0;
    if (depth != level) {
        return getNodeCountRec(tree->left, level, depth + 1) + getNodeCountRec(tree->right, level, depth + 1);
    } else {
        if (tree->left != NULL && tree->right != NULL)
            return 2;
        else if (tree->left != NULL || tree->right != NULL)
            return 1;
        else
            return 0;
    }
}

int getNodeCount(struct Tree* tree, int level) {
    if (level == 0) return 1;
    return getNodeCountRec(tree, level - 1, 0);
}

void treeprint(struct Tree* root, int level)
{
        if (root == NULL)
                return;
        for (int i = 0; i < level; i++)
                printf(i == level - 1 ? "|-" : "  ");
        printf("%d\n", root->data);
        treeprint(root->left, level + 1);
        treeprint(root->right, level + 1);
}

    


int main() {
    struct Tree* tree = (struct Tree*) malloc(sizeof(struct Tree));

    tree->data = 0;
    tree->left = (struct Tree*) malloc(sizeof(struct Tree));
    tree->right = (struct Tree*) malloc(sizeof(struct Tree));
    tree->left->left = (struct Tree*) malloc(sizeof(struct Tree));
    tree->left->right = (struct Tree*) malloc(sizeof(struct Tree));
    tree->right->left = (struct Tree*) malloc(sizeof(struct Tree));
    tree->right->right = (struct Tree*) malloc(sizeof(struct Tree));
    tree->right->right->right = (struct Tree*) malloc(sizeof(struct Tree));

    treeprint(tree, 0);

    printf("%d", getNodeCount(tree, 2));

    return 0;
}