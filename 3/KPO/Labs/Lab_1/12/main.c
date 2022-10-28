#include <stdio.h>

int main() {
    double a;
    int n;
    scanf("%lf %d", &a, &n);

    
    double res1 = 0, val;
    for (int i = 0; i <= n; i++) {
        double denum = 1;
        for (int j = 0; j <= i; j++)
            denum *= a + j;
        res1 += 1.0 / denum;
    }

    double res2 = 1.0/a;
    val = 1.0;

    for (int i = 0; i < n; i++) {
        val *= a*a;
        res2 += 1.0 / val;
    }

    printf("%lf %lf", res1, res2);

    return 0;
}