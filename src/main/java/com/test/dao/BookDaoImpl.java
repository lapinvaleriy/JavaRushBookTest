package com.test.dao;

import com.test.model.Book;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BookDaoImpl implements BookDao {

    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addBook(Book book) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(book);
    }

    @Override
    public void removeBook(int id) {
        Session session = sessionFactory.getCurrentSession();
        Book book = session.load(Book.class, id);

        if (book != null) {
            session.delete(book);
        }
    }

    @Override
    public void updateBook(Book book) {
        Session session = sessionFactory.getCurrentSession();
        session.update(book);
    }

    @Override
    public Book getBookById(int id) {
        Session session = sessionFactory.getCurrentSession();

        return session.get(Book.class, id);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Book> getAllBooks() {
        Session session = sessionFactory.getCurrentSession();

        return session.createQuery("from Book").list();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Book> getBooksByTitle(String title) {
        Session session = sessionFactory.getCurrentSession();

        return session.createQuery("from Book where title = \'" + title + "\'").list();
    }
}
