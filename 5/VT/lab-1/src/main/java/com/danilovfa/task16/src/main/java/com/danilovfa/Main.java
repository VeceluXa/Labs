package com.danilovfa;

import com.danilovfa.comparators.AuthorComparator;
import com.danilovfa.comparators.PriceComparator;
import com.danilovfa.comparators.TitleComparator;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class Main {
    public static List<Book> books = new ArrayList<Book>();

    static {
        books.add(new Book("title4", "author3", 14, 0));
        books.add(new Book("title3", "author6", 9, 0));
        books.add(new Book("title2", "author0", 4, 0));
        books.add(new Book("title1", "author-1", 1, 0));
        books.add(new Book("title0", "author312", 4, 0));
    }

    public static void main(String[] args) {
        Comparator<Book> titleComparator = new TitleComparator();
        Comparator<Book> titleAuthorComparator = new TitleComparator().thenComparing(new AuthorComparator());
        Comparator<Book> authorTitleComparator = new AuthorComparator().thenComparing(new TitleComparator());
        Comparator<Book> authorTitlePriceComparator = new AuthorComparator().thenComparing(new TitleComparator().thenComparing(new PriceComparator()));

        ArrayList<Book> bookArrayList = new ArrayList<>();

        books.sort(titleComparator);
        System.out.println(books);
        books.sort(titleAuthorComparator);
        System.out.println(books);
        books.sort(authorTitleComparator);
        System.out.println(books);
        books.sort(authorTitlePriceComparator);
        System.out.println(books);
    }
}