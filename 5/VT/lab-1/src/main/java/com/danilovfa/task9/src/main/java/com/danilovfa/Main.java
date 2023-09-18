package com.danilovfa;

public class Main {
    public static void main(String[] args) {
        Basket basket = new Basket();
        basket.addBall(new Ball(15.0, Color.BLUE));
        basket.addBall(new Ball(1.0, Color.RED));
        basket.addBall(new Ball(12.0, Color.GREEN));
        basket.addBall(new Ball(7.0, Color.BLUE));
        System.out.println(basket.getWeightOfAllBalls());
    }
}