package bai3;

public class Cat extends Animal{
    public Cat(String name) {
        super(name);
    }

    @Override
    public void makeSound() {
        System.out.println(getName() + " kêu: Meo Meo!");
    }

    @Override
    public void move() {
        System.out.println(getName() + " nhảy và đi nhẹ nhàng.");
    }
}
