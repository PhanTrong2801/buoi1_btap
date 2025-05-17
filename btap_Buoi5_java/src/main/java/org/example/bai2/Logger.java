package org.example.bai2;

public class Logger {
    private Logger(){
    }

    private static class LoggerHolder{
        private static final Logger instance = new Logger();
    }

    public static Logger getInstance(){
        return LoggerHolder.instance;
    }

    public static void log(String message){
        System.out.println("[LOG]"+ message);
    }
}
