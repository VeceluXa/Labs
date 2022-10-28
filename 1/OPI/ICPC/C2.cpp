#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

int fearSum(string a, string b) {
    int fear = 0;

    // if (a.length() > b.length()) {
    //     b 
    // }

    reverse(a.begin(), a.end());
    reverse(b.begin(), b.end());

    // a > b
    if (b.length() > a.length())
        swap(a, b);
    
    for (int i = 0; i < b.length(); i++) {
        if (a[i] - '0' + b[i] - '0' > 10) {
            fear++;
            a[i+1] += a[i] - '0' + b[i] - '0'; 
        }
    }

    if (a[b.length()] - '0' > 10)
        fear++;

    return fear;
}

int fearSum(int a, int b) {
    int fear = 0;

    if(b > a)
        swap(a, b);

    int count = 0;
    for(int i = 0; i < trunc(log10(b)) + 2; i++) {
        if (a % 10 + b % 10 + count > 9) {
            fear++;
            a /= 10;
            b /= 10;
            count = 1;
        } else {
            a /= 10;
            b /= 10;
            count = 0;
        }
    }
    return fear;
}

int main() {
    // Input
    int n;
    cin >> n;
    vector<int> num(n);
    for (int i = 0; i < n; i++)
        cin >> num[i];

    int fear = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            fear += fearSum(num[i], num[j]);
        }
    }

    cout << fear;
    return 0;
}