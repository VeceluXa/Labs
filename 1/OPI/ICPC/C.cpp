#include <iostream>
#include <vector>
#include <string>

using namespace std;

int main(){
	// Input
    int n;
    cin >> n;
    vector<int> numbers(n);
	for(int i = 0; i < n; i++)
		cin >> numbers[i];
	
	int fear = 0;
	int sums_l;
	string sums;
	int sum;
	for(int j = 0; j < n; j++) {
		for(int k = j + 1; k < n; k++) {
			sum = numbers[j] + numbers[k];
			sums = to_string(sum);
			sums_l = sums.length();
			if(sums_l > to_string(numbers[j]).length() && sums_l > to_string(numbers[k]).length()){
				fear += sums_l - 1;
			}
		}
	}
	cout << fear;
	return 0;
}