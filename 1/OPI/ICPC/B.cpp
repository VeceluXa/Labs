#include <iostream>

using namespace std;

int main() {
    string num;
    cin >> num;

    int count0 = 0;
    int count1 = 0;
    int count2 = 0;

    for (int i = 0; i < num.size(); i++) {
        count0 += (num[i] == '0');
        count1 += (num[i] == '1');
        count2 += (num[i] == '2');    
    }

    if (count0 == 1 && count1 == 1 && count2 == 2)
        cout << "YES";
    else
        cout << "NO";

}