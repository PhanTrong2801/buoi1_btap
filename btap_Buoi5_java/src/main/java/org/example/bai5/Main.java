package org.example.bai5;

public class Main {
    public static void main(String[] args) {
        Notification notification1 = NotificationFactory.createNotification("email");
        notification1.send();

        Notification notification2 = NotificationFactory.createNotification("sms");
        notification2.send();

        Notification notification3 = NotificationFactory.createNotification("push");
        notification3.send();
    }
}
