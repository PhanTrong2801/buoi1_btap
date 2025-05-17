package org.example.bai3;

public class Main {
    public static void main(String[] args) {
        Runnable task = () -> {
            DatabaseConnection db = DatabaseConnection.INSTANCE;
            db.connect();
            db.executeQuery("SELECT * FROM users WHERE active = 1");
        };

        Thread t1 = new Thread(task, "Thread-1");
        Thread t2 = new Thread(task, "Thread-2");
        Thread t3 = new Thread(task, "Thread-3");

        t1.start();
        t2.start();
        t3.start();
    }
}
