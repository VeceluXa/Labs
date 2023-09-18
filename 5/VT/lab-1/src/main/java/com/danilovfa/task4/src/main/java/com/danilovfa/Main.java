package com.danilovfa;

import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        System.out.println(getPrimeNumbers(3));
    }

    public static List<Integer> getPrimeNumbers(int n) {
        List<Integer> resultList = new ArrayList<>();

        List<Boolean> isPrimeList = new ArrayList<>(n);
        for (int i = 0; i < n; i++) {
            isPrimeList.add(true);
        }

        for (int i = 2; i <= Math.sqrt(n); i++) {
            if (isPrimeList.get(i)) {
                for (int j = i * i; j < n; j += i) {
                    isPrimeList.set(j, false);
                }
            }
        }

        for (int i = 0; i < isPrimeList.size(); i++) {
            if (isPrimeList.get(i)) {
                resultList.add(i + 1);
            }
        }

        return resultList;
    }
}
