package Homework;

public class Zombie extends GameObject implements Mover{
    public Zombie(int x, int y) {
        super(150, x, y);
    }

    @Override
    public void move() {
        x -= 1;
        System.out.println("🧟 Zombie di chuyển tới (" + x + ", " + y + ")");
    }

    @Override
    public void update() {
        move();
    }
}
