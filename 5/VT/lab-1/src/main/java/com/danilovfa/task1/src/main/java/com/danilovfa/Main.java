package com.danilovfa;

import static java.lang.Math.*;

public class Main {
    public static void main(String[] args) {
        System.out.println(calculate(4.5, 3.2));
    }

    public static double calculate(double x, double y) {
        double numerator = 1 + pow(sin(x + y), 2);
        double denumerator = 2 + abs(x - (2 * x) / (1 + pow(x * y, 2)));
        double result = numerator / denumerator + x;

        return result;
    }
}
