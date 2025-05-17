package org.example.bai7;

public class Main {
    public static void main(String[] args) {
        String os = "windows"; // hoặc "mac"

        GUIFactory factory;
        if (os.equalsIgnoreCase("windows")) {
            factory = new WindowsFactory();
        } else {
            factory = new MacFactory();
        }

        Application app = new Application(factory);
        app.renderUI();
    }
}
