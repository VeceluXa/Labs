#include <stdio.h>
#include <math.h>

int main() {
    int a, n;
    scanf("%d %d", &a, &n);

    int res1 = (int)pow(a, n);
    int res2 = 1;
    for(int i = 0; i < n; i++)
        res2 *= a + i;

    printf("%d %d", res1, res2);

    return 0;
}