package com.danilovfa;

public class Book implements Comparable<Book> {
    private String title;
    private String author;
    private int price;
    private int isbn;

    public Book(String title, String author, int price, int isbn) {
        this.title = title;
        this.author = author;
        this.price = price;
        this.isbn = isbn;
    }

    @Override
    public int hashCode() {
        return 10 * title.hashCode() + 31 * author.hashCode() + 20456;
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Book)) return false;
        if (obj.hashCode() != hashCode()) return false;

        Book book = (Book) obj;
        return this.title.equals(book.title) &&
                this.author.equals(book.author) &&
                this.price == book.price && this.isbn == book.isbn;
    }

    @Override
    public String toString() {
        return "Title:" + title + "|Author:" + author + "|Price:" + price + "|isbn:" + isbn;
    }

    @Override
    public int compareTo(Book book) {
        return isbn - book.isbn;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public int getPrice() {
        return price;
    }

    public int getIsbn() {
        return isbn;
    }
}
