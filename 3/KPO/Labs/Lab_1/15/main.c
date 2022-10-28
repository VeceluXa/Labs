#include <stdio.h>

int main() {
    int n, k;
    scanf("%d %d", &n, &k);
    int num = n, denum = 1;
    for (int i = 1; i < k; i++) {
        num *= n - i;
        denum *= i;
    }
    denum *= k;
    double res = (double)num/(double)denum;
    printf("%lf", res);

    return 0;
}