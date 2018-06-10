package com.test.dao;

import com.test.model.Book;

import java.util.List;

public interface BookDao {
    void addBook(Book book);

    void removeBook(int id);

    void updateBook(Book book);

    Book getBookById(int id);

    List<Book> getAllBooks();

    List<Book> getBooksByTitle(String title);
}
