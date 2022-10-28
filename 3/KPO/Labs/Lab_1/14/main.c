#include <stdio.h>

int main() {
    double x;
    scanf("%lf", &x);

    double res = x, num = x, val = 1;
    long long denum = 1;

    for (int i = 1; i <= 6; i++) {
        num *= (-1)*x*x;
        denum *= (i*2)*(i*2+1);
        val = num/(double)denum;
        res += val;
    }

    printf("%lf", res);
    
    return 0;
}