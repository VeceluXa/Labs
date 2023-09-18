package com.danilovfa;

import java.util.ArrayList;
import java.util.List;

public class Basket {
    private List<Ball> balls;

    public Basket(List<Ball> balls) {
        this.balls = balls;
    }

    public Basket() {
        this.balls = new ArrayList<Ball>();
    }

    public Double getWeightOfAllBalls() {
        double resultWeight = 0.0;

        for (Ball ball : balls) {
            resultWeight += ball.weight;
        }

        return resultWeight;
    }

    public Integer countBlueBalls() {
        int blueBallsCount = 0;

        for (Ball ball : balls) {
            if (ball.color == Color.BLUE) {
                blueBallsCount++;
            }
        }

        return blueBallsCount;
    }

    public void addBall(Ball ball) {
        balls.add(ball);
    }

    public List<Ball> getBalls() {
        return balls;
    }
}
