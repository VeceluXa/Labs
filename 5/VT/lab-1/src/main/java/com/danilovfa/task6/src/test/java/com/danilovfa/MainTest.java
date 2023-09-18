package com.danilovfa;

import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {

    @Test
    public void getMatrixTest() {
        double[][] actual = Main.createMatrix(new double[]{1, 2, 3, 4, 5, 6, 7, 8, 9});
        assertEquals(81, actual.length * actual[0].length);
    }

}