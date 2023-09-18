package com.danilovfa;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {
    @Test
    public void cloneTest() {
        Book book = new Book("Title", "Author", 15000, 1234567);
        try {
            assertEquals(book, book.clone());
        } catch (Exception e) {
            e.printStackTrace();
            fail();
        }

    }
}