package org.example.bai1;

public class Main1 {
    public static void main(String[] args) {

        AppConfig config  = AppConfig.getInstance();

        System.out.println("App Name: " + config.getAppName());
        System.out.println("Version: "+config.getVersion());

        config.setVersion("2.0");

        AppConfig config2 = AppConfig.getInstance();
        System.out.println("Version khac: "+config2.getVersion());
    }
}
