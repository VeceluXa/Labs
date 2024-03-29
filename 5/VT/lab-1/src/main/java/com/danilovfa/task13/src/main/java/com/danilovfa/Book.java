package com.danilovfa;


public class Book {
    private String title;
    private String author;
    private int price;
    private static int edition;

    @Override
    public int hashCode() {

        return 10 * title.hashCode() + 31 * author.hashCode() + 20456;
    }

    @Override
    public boolean equals(Object obj) {

        if (!(obj instanceof Book)) {
            return false;
        }
        if (obj.hashCode() != hashCode()) {
            return false;
        }

        Book book = (Book) obj;
        return this.title.equals(book.title) && this.author.equals(book.author) && this.price == book.price;
    }

    @Override
    public String toString() {

        return "Title:" + title + "|Author:" + author + "|Price:" + price + "|Edition:" + edition;
    }
}
