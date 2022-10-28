#include <iostream>
#include <cmath>

using namespace std;

int main() {
    int l;
    cin >> l;

    int count = 0;
    for (int i = 1; i < l; i++) {
        if (l % i == 0 && l / i == 3) {
            count++;
            continue;
        }
        // base == i
        if ((l - i) % 2 == 0 && i < (l - i))
            count++;

        // side == i
        if (i > abs(l-3*i) && i < (l - i))
            count+=2;
    }

    cout << count;
    return 0;
}