package com.danilovfa;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {

    @Test
    public void calculateTest() {
        String actual = Main.calculate(-1, 1, 0.2);
        int actualLines = actual.split("\n").length;
        assertEquals(11, actualLines);
    }
}