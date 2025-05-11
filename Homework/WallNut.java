package Homework;

public class WallNut extends GameObject{
    public WallNut(int x, int y) {
        super(300, x, y); // máu rất cao
    }

    @Override
    public void update() {
        System.out.println("WallNut đứng chắn tại (" + x + ", " + y + "), máu: " + health);
    }
}
