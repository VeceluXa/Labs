package com.danilovfa;

import com.danilovfa.comparators.TitleComparator;
import org.junit.jupiter.api.Test;

import java.util.Comparator;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {
    @Test
    public void comparatorsTest() {
        List<Book> books = Main.books;

        Comparator<Book> titleComparator = new TitleComparator();
        books.sort(titleComparator);
        assertEquals("title0", books.get(0).getTitle());
    }
}