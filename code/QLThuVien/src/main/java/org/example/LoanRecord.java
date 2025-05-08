package org.example;

import java.time.LocalDate;

public class LoanRecord {
    private User user;
    private Book book;
    private LocalDate loanDate;
    private LocalDate returnDate;

    public LoanRecord(User user, Book book, LocalDate loanDate, LocalDate returnDate) {
        this.user = user;
        this.book = book;
        this.loanDate = loanDate;
        this.returnDate = returnDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public LocalDate getLoanDate() {
        return loanDate;
    }

    public void setLoanDate(LocalDate loanDate) {
        this.loanDate = loanDate;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    @Override
    public String toString() {
        return "LoanRecord{" +
                "user=" + user +
                ", book=" + book +
                ", loanDate=" + loanDate +
                ", returnDate=" + returnDate +
                '}';
    }
}
