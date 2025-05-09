package bai3;

import java.util.ArrayList;
import java.util.HashMap;

public class Zoo {
    private ArrayList<Animal> animals = new ArrayList<>();

    public void addAnimal(Animal a) {
        animals.add(a);
    }

    public void showAllAnimals() {
        for (Animal a : animals) {
            a.makeSound();
            a.move();
            System.out.println();
        }
    }

    public void countBySpecies() {
        int dogCount = 0;
        int catCount = 0;
        int birdCount = 0;

        for (Animal a : animals) {
            if (a instanceof Dog) {
                dogCount++;
            } else if (a instanceof Cat) {
                catCount++;
            } else if (a instanceof Bird) {
                birdCount++;
            }
        }

        System.out.println("📊 Thống kê số lượng mỗi loài:");
        System.out.printf("- Dog: %d con\n", dogCount);
        System.out.printf("- Cat: %d con\n", catCount);
        System.out.printf("- Bird: %d con\n", birdCount);
    }
}
