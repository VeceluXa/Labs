package com.danilovfa;

public class Main {

    public static void main(String[] args) {
        System.out.println(calculate(0.0, 10.0, 0.5));
    }


    /**
     * Calculate function tan(x) in a range [a, b] with step h.
     *
     * @param h step
     * @param a starting value
     * @param b stopping value
     * @return table of parameters and calculations
     */
    public static String calculate(double a, double b, double h) {
        StringBuilder sb = new StringBuilder();

        double x = a;
        while (x <= b) {
            double result = Math.tan(x);
            sb.append(x).append(" - ").append(result).append("\n");

            x += h;
        }

        return sb.toString();
    }
}
