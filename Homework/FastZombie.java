package Homework;

public class FastZombie extends Zombie{
    public FastZombie(int x, int y) {
        super(x, y);
        this.health = 100; // máu ít hơn zombie thường
    }

    @Override
    public void move() {
        x -= 2; // di chuyển 2 ô mỗi lượt
        System.out.println("FastZombie di chuyển nhanh tới (" + x + ", " + y + ")");
    }
}
