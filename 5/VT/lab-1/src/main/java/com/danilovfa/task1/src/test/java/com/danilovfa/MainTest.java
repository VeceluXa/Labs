package com.danilovfa;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {
    @Test
    public void testCalculate() {
        double actual = Math.round(Main.calculate(14.0, 22.0));
        assertEquals(14, actual);
    }
}