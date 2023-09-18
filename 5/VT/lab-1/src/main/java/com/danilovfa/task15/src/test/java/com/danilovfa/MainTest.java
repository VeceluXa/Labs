package com.danilovfa;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {
    @Test
    public void comparatorTest() {
        Book[] actual = Main.sort(Main.arr);
        assertEquals(0, actual[0].isbn);
        assertEquals(8, actual[6].isbn);
    }
}