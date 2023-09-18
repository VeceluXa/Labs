package com.danilovfa;

import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {
    @Test
    public void getIndexesTest() {
        List<Double> actual = Main.getIndexes(new double[]{1, 2, 3, 4, 5, 6}, new double[]{0, 4, 6, 8, 9, 10});
        assertEquals(6, actual.size());
    }
}