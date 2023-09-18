package com.danilovfa;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {

    @Test
    public void isDotInAreaTest() {
        boolean actual = Main.isDotInArea(-3, 4);
        assertTrue(actual);
    }
}