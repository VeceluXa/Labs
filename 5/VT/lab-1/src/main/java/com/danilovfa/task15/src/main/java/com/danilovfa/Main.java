package com.danilovfa;

import java.util.Arrays;

public class Main {
    public static Book[] arr = {
            new Book("a", "a", 1, 5),
            new Book("b",  "b", 1, 4),
            new Book("c",  "c", 1, 8),
            new Book("d",  "d", 1, 1),
            new Book("e",  "e", 1, 5),
            new Book("f", "f", 1, 0),
            new Book("g", "g", 1, 3)};

    public static void main(String[] args) {
        Book[] newArr = sort(arr);
        System.out.println(Arrays.toString(newArr));
    }

    public static Book[] sort(Book[] arr) {
        Arrays.sort(arr);
        return arr.clone();
    }
}
