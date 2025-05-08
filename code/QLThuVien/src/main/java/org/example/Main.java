package org.example;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        ArrayList<Book> books = new ArrayList<>();
        ArrayList<User> users = new ArrayList<>();
        ArrayList<LoanRecord> loanRecords = new ArrayList<>();

        // Dữ liệu mẫu
        books.add(new Book("B1", "Java Basics", "John Smith", true));
        books.add(new Book("B2", "Python 101", "Jane Doe", true));

        users.add(new User("U1", "Alice"));
        users.add(new User("U2", "Bob"));

        Scanner scanner = new Scanner(System.in);
        int choice;

        do {
            System.out.println("\n===== MENU =====");
            System.out.println("1. Muon sach");
            System.out.println("2. Tra sach");
            System.out.println("3. Hien thi danh sach sach dang duoc muon");
            System.out.println("4. Hien thi danh sach sach da duoc tra");
            System.out.println("5. Tim sach da duoc muon cua mot nguoi dung");
            System.out.println("0. Thoat");
            System.out.print("Chon chuc nang: ");
            choice = Integer.parseInt(scanner.nextLine());

            switch (choice) {
                case 1:
                    borrowBook(scanner, users, books, loanRecords);
                    break;
                case 2:
                    returnBook(scanner, loanRecords);
                    break;
                case 3:
                    showBorrowedBooks(loanRecords);
                    break;
                case 4:
                    showReturnedBooks(loanRecords);
                    break;
                case 5:
                    findBooksByUser(scanner, loanRecords);
                    break;

                case 0:
                    System.out.println("Tam biet!");
                    break;
                default:
                    System.out.println("Lua chon khong hop le.");
            }

        } while (choice != 0);
    }

    private static void borrowBook(Scanner scanner, ArrayList<User> users, ArrayList<Book> books, ArrayList<LoanRecord> records) {
        if (books.isEmpty() || users.isEmpty()) {
            System.out.println(" Chua co sach hoac nguoi dung.");
            return;
        }

        // Chon nguoi dung
        System.out.println("Danh sach nguoi dung:");
        for (int i = 0; i < users.size(); i++) {
            System.out.println((i + 1) + ". " + users.get(i));
        }
        System.out.print("Chon nguoi dung (so thu tu): ");
        int userIndex = Integer.parseInt(scanner.nextLine()) - 1;

        if (userIndex < 0 || userIndex >= users.size()) {
            System.out.println(" Lua chon khong hop le.");
            return;
        }

        User selectedUser = users.get(userIndex);

        // Chon sach
        System.out.println("Danh sach sach co san:");
        ArrayList<Book> availableBooks = new ArrayList<>();
        for (Book book : books) {
            if (book.isAvailable()) {
                availableBooks.add(book);
            }
        }

        if (availableBooks.isEmpty()) {
            System.out.println("Khong co sach co san.");
            return;
        }

        for (int i = 0; i < availableBooks.size(); i++) {
            System.out.println((i + 1) + ". " + availableBooks.get(i));
        }

        System.out.print("Chon sach (so thu tu): ");
        int bookIndex = Integer.parseInt(scanner.nextLine()) - 1;

        if (bookIndex < 0 || bookIndex >= availableBooks.size()) {
            System.out.println(" Lua chon khong hop le.");
            return;
        }

        Book selectedBook = availableBooks.get(bookIndex);
        selectedBook.setAvailable(false); // cap nhat trang thai sach

        LoanRecord record = new LoanRecord(selectedUser, selectedBook, LocalDate.now(), null);
        records.add(record);

        System.out.println(" Muon sach thanh cong: " + record);
    }


    private static void returnBook(Scanner scanner, ArrayList<LoanRecord> records) {
        ArrayList<LoanRecord> activeLoans = new ArrayList<>();

        for (LoanRecord record : records) {
            if (record.getReturnDate() == null) {
                activeLoans.add(record);
            }
        }

        if (activeLoans.isEmpty()) {
            System.out.println(" Khong co sach nao dang duoc muon.");
            return;
        }

        System.out.println("Danh sach sach dang duoc muon:");
        for (int i = 0; i < activeLoans.size(); i++) {
            LoanRecord lr = activeLoans.get(i);
            System.out.println((i + 1) + ". " + lr.getBook().getTitle() + " - Nguoi muon: " + lr.getUser().getName() + ", Ngay muon: " + lr.getLoanDate());
        }

        System.out.print("Chon sach de tra (so thu tu): ");
        int index = Integer.parseInt(scanner.nextLine()) - 1;

        if (index < 0 || index >= activeLoans.size()) {
            System.out.println(" Lua chon khong hop le.");
            return;
        }

        LoanRecord record = activeLoans.get(index);
        record.setReturnDate(LocalDate.now());
        record.getBook().setAvailable(true);

        System.out.println("Da tra sach thanh cong: " + record.getBook().getTitle());
    }


    private static void showBorrowedBooks(ArrayList<LoanRecord> records) {
        boolean hasBorrowed = false;

        System.out.println("Danh sach sach dang duoc muon:");
        for (LoanRecord record : records) {
            if (record.getReturnDate() == null) {
                System.out.println("- " + record.getBook().getTitle()
                        + " | Tac gia: " + record.getBook().getAuthor()
                        + " | Nguoi muon: " + record.getUser().getName()
                        + " | Ngay muon: " + record.getLoanDate());
                hasBorrowed = true;
            }
        }

        if (!hasBorrowed) {
            System.out.println(" Khong co sach nao dang duoc muon.");
        }
    }


    private static void showReturnedBooks(ArrayList<LoanRecord> records) {
        boolean hasReturned = false;

        System.out.println("Danh sach sach da duoc tra:");
        for (LoanRecord record : records) {
            if (record.getReturnDate() != null) {
                System.out.println("- " + record.getBook().getTitle()
                        + " | Tac gia: " + record.getBook().getAuthor()
                        + " | Nguoi muon: " + record.getUser().getName()
                        + " | Ngay muon: " + record.getLoanDate()
                        + " | Ngay tra: " + record.getReturnDate());
                hasReturned = true;
            }
        }

        if (!hasReturned) {
            System.out.println("Chua co sach nao duoc tra.");
        }
    }

    private static void findBooksByUser(Scanner scanner, ArrayList<LoanRecord> records) {
        // Chọn người dùng
        System.out.println("Danh sach nguoi dung:");
        ArrayList<User> users = new ArrayList<>();
        for (LoanRecord record : records) {
            if (!users.contains(record.getUser())) {
                users.add(record.getUser());
            }
        }

        for (int i = 0; i < users.size(); i++) {
            System.out.println((i + 1) + ". " + users.get(i).getName());
        }

        System.out.print("Chon nguoi dung (so thu tu): ");
        int userIndex = Integer.parseInt(scanner.nextLine()) - 1;

        if (userIndex < 0 || userIndex >= users.size()) {
            System.out.println(" Lua chon khong hop le.");
            return;
        }

        User selectedUser = users.get(userIndex);

        // Lọc các sách mà người dùng đã mượn
        boolean foundBooks = false;
        System.out.println(" Danh sach sach da duoc muon cua " + selectedUser.getName() + ":");

        for (LoanRecord record : records) {
            if (record.getUser().equals(selectedUser) && record.getReturnDate() == null) {
                System.out.println("- " + record.getBook().getTitle()
                        + " | Tac gia: " + record.getBook().getAuthor()
                        + " | Ngay muon: " + record.getLoanDate());
                foundBooks = true;
            }
        }

        if (!foundBooks) {
            System.out.println("Khong co sach nao da duoc muon.");
        }
    }

}
