package org.example.bai3;

public enum DatabaseConnection {
    INSTANCE;

    private boolean connected = false;

    public void connect(){
        if(!connected){
            System.out.println("Dang ket noi den co so du lieu...");

            try{
                Thread.sleep(1000);
            }catch (InterruptedException e){
                e.printStackTrace();
            }
            connected = true;
            System.out.println("Ket noi thanh cong!");
        }else {
            System.out.println("Da ket noi trc do");
        }
    }

    public void executeQuery(String sql){
        if(!connected){
            System.out.println("Chua ket noi den database!");
            return;
        }
        System.out.println("Thuc thi cau lenh SQL: "+sql);
    }
}
