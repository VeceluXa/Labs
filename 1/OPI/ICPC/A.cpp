#include <iostream>

using namespace std;

int main()
{
    int l;
    cin >> l;
    int counter = 0;
    int a = 0;
    if (l % 2 == 1)
    {
        for (int i = 1; i <= l / 2; i += 2)
        {
            if (l - i > i && (l - i) / 2 != i) counter += 3;
        }
    }
    else
    {
        for (int i = 2; i < l / 2; i += 2)
        {
            if ((l - i) > i && (l - i) / 2 != i) counter += 3;
        }
    }
    counter += l % 3 == 0? 1: 0;
    cout << counter << endl;
    return 0;
}