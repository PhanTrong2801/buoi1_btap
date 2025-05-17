package org.example.bai2;

public class Main {
    public static void main(String[] args) {
        Runnable task = ()->{
            Logger logger = Logger.getInstance();
            Logger.log("Thread "+Thread.currentThread().getName() + "is loggin,");
        };
        Thread t1 = new Thread(task,"1");
        Thread t2 = new Thread(task,"2");
        Thread t3 = new Thread(task,"3");

        t1.start();
        t2.start();
        t3.start();
    }
}
