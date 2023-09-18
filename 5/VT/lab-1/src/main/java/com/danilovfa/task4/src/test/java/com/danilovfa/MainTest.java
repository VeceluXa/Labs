package com.danilovfa;

import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {
    @Test
    public void getPrimeNumbersTest() {
        List<Integer> actual = Main.getPrimeNumbers(15);
        assertEquals(8, actual.size());
    }
}