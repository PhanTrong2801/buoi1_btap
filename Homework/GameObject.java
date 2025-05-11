package Homework;

public abstract class GameObject {
    protected int health;
    protected int x;
    protected int y;

    public GameObject(int health, int x, int y) {
        this.health = health;
        this.x = x;
        this.y = y;
    }

    public abstract void update();

    public void takeDamage(int amount){
        health -= amount;
        if(health<0){
            health = 0;
        }
    }

    public boolean isAlive(){
        return health > 0;
    }

    public int getHealth() {
        return health;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public void setPosition(int x, int y) {
        this.x = x;
        this.y = y;
    }
}
