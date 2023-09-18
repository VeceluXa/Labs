package com.danilovfa;

public class Main {
    public static void main(String[] args) {
        System.out.println(isDotInArea(4, 3));
    }

    public static boolean isDotInArea(int x, int y) {
        return (x >= -6 && x <= 6 && y >= -3 && y <= 0) ||
                (x >= -4 && x <= 4 && y >= 0 && y <= 5);
    }
}
