package com.danilovfa;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {
    @Test
    public void sortTest() {
        double[] actual = Main.sort(new double[]{4, 3, 2, 1, 52, 21, 14, 3152, 163, 112, 511, 12, 444, 124, 1, 4, 124, 567});
        assertEquals(18, actual.length);
    }
}