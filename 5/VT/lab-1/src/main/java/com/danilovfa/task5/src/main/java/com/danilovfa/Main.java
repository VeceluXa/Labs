package com.danilovfa;

public class Main {
    private static final int MIN = -2147483648;
    private static final int MAX = 2147483647;

    public static void main(String[] args) {
        int result = findLeastNumberOfElements(new int[]{13, 51, 93, 91, 42, 36, 96, 37, 27, 18});
        System.out.println(result);
    }

    public static int findLeastNumberOfElements(int[] arr) {
        boolean isSorted = true;
        for (int i = 0; i < arr.length - 1; i++) {
            if (arr[i] > arr[i + 1]) {
                isSorted = false;
                break;
            }
        }

        if (isSorted) {
            return 0;
        }

        int n = arr.length;
        int length = 0;

        int[] extraArray = new int[n];
        extraArray[0] = MIN;
        for (int i = 1; i < n; i++) {
            extraArray[i] = MAX;
        }

        for (int i = 0; i < n - 1; i++) {
            int j = binarySearch(extraArray, 0, n - 1, arr[i]);
            if (extraArray[j - 1] < arr[i] && arr[i] < extraArray[j]) {
                extraArray[j] = arr[i];
                length = Math.max(length, j);
            }
        }
        return n - length;
    }

    private static int binarySearch(int[] arr, int l, int r, int sElem) {
        int m = -1;
        if (sElem < arr[l]) {
            return l;
        }
        if (sElem > arr[r]) {
            return r;
        }
        while (l <= r) {
            m = (l + r) / 2;
            if (sElem >= arr[m] && sElem < arr[m + 1]) {
                return m + 1;
            }
            if (sElem < arr[m]) r = m - 1;
            if (sElem > arr[m]) l = m + 1;
        }
        return m;
    }
}
