package com.danilovfa;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {

    @Test
    public void findLeastNumberOfElementsTest() {
        Integer actual = Main.findLeastNumberOfElements(new int[]{13, 51, 93, 91, 42, 36, 96, 37, 27, 18});
        assertEquals(6, actual);
    }

}