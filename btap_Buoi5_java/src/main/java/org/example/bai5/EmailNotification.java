package org.example.bai5;

public class EmailNotification implements Notification{

    @Override
    public void send() {
        System.out.println("Sending Email Notification");
    }
}
