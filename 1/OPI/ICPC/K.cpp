#include <iostream>
#include <cmath>

using namespace std;

int floorSqrt(int x) {
    int ans;

    if (x == 0 || x == 1)
        return x;

    int begin = 1, end = x;
    while(begin <= end) {
        int mid = (begin + end) / 2;

        if ((mid*mid <= x) && (mid + 1)*(mid + 1) > x)
            return mid;
        
        if (mid*mid < x) {
            begin = mid + 1;
            ans = mid;
        }
        else 
            end = mid - 1;
    }

    return ans;
}

int main() {
	int n, m;
	cin >> n >> m;
	int* arr = new int[n];
	for (int i = 0; i < n; i++) 
        cin >> arr[i];

    int a;
    int ans = 0;
	for (int i = 0; i < m; i++) {
		cin >> a;
		for (int j = 0; j < n; j++)
            ans += floorSqrt(abs(a - arr[j]));
	}
	cout << ans;
	return 0;
}