package bai3;

public class Main {
    public static void main(String[] args) {
        Zoo zoo = new Zoo();

        zoo.addAnimal(new Dog("Chó Vàng"));
        zoo.addAnimal(new Cat("Mèo Mun"));
        zoo.addAnimal(new Bird("Chim Sâu"));
        zoo.addAnimal(new Dog("Chó Mực"));
        zoo.addAnimal(new Cat("Mèo Tam Thể"));

        System.out.println(" Tiếng kêu và di chuyển của các con vật:");
        zoo.showAllAnimals();

        zoo.countBySpecies();
    }
}
