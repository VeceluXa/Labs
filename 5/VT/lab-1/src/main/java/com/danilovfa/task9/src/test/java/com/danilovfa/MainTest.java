package com.danilovfa;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {
    @Test
    public void basketTest() {
        Basket basket = new Basket();
        basket.addBall(new Ball(15.0, Color.BLUE));
        basket.addBall(new Ball(1.0, Color.RED));
        basket.addBall(new Ball(12.0, Color.GREEN));
        basket.addBall(new Ball(7.0, Color.BLUE));

        Double actual = basket.getWeightOfAllBalls();
        assertEquals(35.0, actual);
    }
}