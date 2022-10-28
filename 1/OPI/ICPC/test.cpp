#include <iostream>
#include <cmath>

using namespace std;

int floorSqrt(int x) {
    int ans;

    if (x == 0 || x == 1)
        return x;


    int start = 1, end = x;
    while(start <= end) {
        int mid = (start + end) / 2;

        if ((mid*mid <= x) && (mid + 1)*(mid + 1) > x)
            return mid;
        
        if (mid*mid < x) {
            start = mid + 1;
            ans = mid;
        }
        else 
            end = mid - 1;
    }

    return ans;
}

int main() {
    int a, b;
    cin >> a >> b;
    cout << floorSqrt(abs(a-b));  
}