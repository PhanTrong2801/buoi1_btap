package org.example.bai5;

public class NotificationFactory {
    public static Notification createNotification(String type) {
        if (type == null) {
            return null;
        }
        switch (type.toLowerCase()) {
            case "email":
                return new EmailNotification();
            case "sms":
                return new SMSNotification();
            case "push":
                return new PushNotification();
            default:
                throw new IllegalArgumentException("Unknown notification type: " + type);
        }
    }
}
