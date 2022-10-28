#include <iostream>
#include <algorithm>

using namespace std;

int main() {

    string num;
    cin >> num;
    
    num = num + num[num.length() - 1] + num.substr(0, num.length() - 1) + num.substr(1, num.length()) + num[0];

    int numSum = 0;
    for (int i = 0; i < num.length(); i++) {
        numSum += (num[i] - '0');
    }

    cout << numSum % 3;

    return 0;
}