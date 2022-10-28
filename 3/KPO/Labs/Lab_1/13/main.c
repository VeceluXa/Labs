#include <stdio.h>
#include <math.h>

int main() {
    double res = 1.0;
    for (int i = 1; i <= 100; i++) {
        res *= 1.0 + sin((double)(i)/10);
    }
    printf("%lf", res);    

    return 0;
}