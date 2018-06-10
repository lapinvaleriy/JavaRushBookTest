package com.test.controller;

import com.test.model.Book;
import com.test.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class BookController {

    private static final int MAX_ROWS = 10;

    private BookService bookService;

    @Autowired
    @Qualifier(value = "bookService")
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    @RequestMapping(value = "/")
    public ModelAndView listBooks(@RequestParam(required = false) Integer page) {
        ModelAndView modelAndView = new ModelAndView("mainPage");

        List<Book> allBooks = bookService.getAllBooks();

        PagedListHolder<Book> pagedListHolder = new PagedListHolder<>(allBooks);
        pagedListHolder.setPageSize(MAX_ROWS);

        modelAndView.addObject("maxPages", pagedListHolder.getPageCount());

        if (page == null || page < 1 || page > pagedListHolder.getPageCount()) {
            page = 1;
        }
        modelAndView.addObject("page", page);

        if (page > pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(0);
            modelAndView.addObject("listBooks", pagedListHolder.getPageList());
        } else if (page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page - 1);
            modelAndView.addObject("listBooks", pagedListHolder.getPageList());
        }

        return modelAndView;
    }

    @RequestMapping(value = "/add")
    public String addBook(@ModelAttribute Book book) {
        return "addAndEditPage";
    }

    @RequestMapping(value = "/edit")
    public ModelAndView editBook(@RequestParam int id) {
        Book book = bookService.getBookById(id);

        return new ModelAndView("addAndEditPage", "book", book);
    }

    @RequestMapping(value = "/remove")
    public String removeBook(@RequestParam int id, @RequestParam int page) {
        bookService.removeBook(id);

        return "redirect:/?page=" + page;
    }

    @RequestMapping(value = "/read")
    public String readBook(@RequestParam int id, @RequestParam int page) {
        Book book = bookService.getBookById(id);

        if (!book.isReadAlready()) {
            book.setReadAlready(true);
            bookService.updateBook(book);
        }

        return "redirect:/?page=" + page;
    }

    @RequestMapping(value = "/search")
    public ModelAndView searchBook(@RequestParam("searchName") String title) {
        List<Book> listBooks = bookService.getBooksByTitle(title);

        return new ModelAndView("mainPage", "listBooks", listBooks);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String saveBook(@ModelAttribute("book") Book book) {
        if (book.getId() == 0) {
            bookService.addBook(book);
        } else {
            if (book.isReadAlready()) {
                book.setReadAlready(false);
            }
            bookService.updateBook(book);
        }
        //для проверяющего
        //для возврата на ту же страницу. Возможно, так делать нехорошо, но работает.
        int page = 0;
        List<Book> allBooks = bookService.getAllBooks();
        for (int i = 0; i < allBooks.size(); i++) {
            if (book.getId() == allBooks.get(i).getId())
                page = i;
        }
        page = (page / 10) + 1;

        return "redirect:/?page=" + page;
    }
}
