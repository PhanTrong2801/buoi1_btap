package Homework;

import java.util.*;

public class Game {
    public static void main(String[] args) {
        // Tạo cây
        Sunflower sunflower = new Sunflower(2, 1);
        WallNut wallNut = new WallNut(4, 1);
        PeaShooter peaShooter = new PeaShooter(5, 1);

        // Tạo zombie
        Zombie fastZombie = new FastZombie(12, 1);

        List<GameObject> plants = new ArrayList<>();
        plants.add(sunflower);
        plants.add(wallNut);
        plants.add(peaShooter);

        int round = 1;

        while (fastZombie.isAlive() && fastZombie.getX() >= 0) {
            System.out.println("\n🔄 Vòng " + round + " ------------------------");

            // Cập nhật tất cả thực thể cây
            for (GameObject plant : plants) {
                plant.update();
            }

            // Zombie di chuyển
            fastZombie.update();

            // Kiểm tra nếu có vật chắn trên đường (WallNut)
            for (GameObject plant : plants) {
                if (plant instanceof WallNut && plant.getX() == fastZombie.getX() && plant.getY() == fastZombie.getY()) {
                    System.out.println("🧟 FastZombie tấn công WallNut!");
                    plant.takeDamage(30);
                    if (!plant.isAlive()) {
                        System.out.println("💥 WallNut đã bị phá hủy!");
                        plants.remove(plant);
                    }
                    break; // Dừng tấn công nếu gặp vật chắn
                }
            }

            // Nếu zombie nằm trong phạm vi bắn của PeaShooter
            if (peaShooter.isAlive() && Math.abs(peaShooter.getX() - fastZombie.getX()) <= 5 &&
                    peaShooter.getY() == fastZombie.getY()) {
                peaShooter.shoot(fastZombie);
            }

            // Kết thúc nếu zombie chết hoặc vượt qua toàn bộ cây
            if (!fastZombie.isAlive()) {
                System.out.println("✅ FastZombie đã bị tiêu diệt!");
                break;
            } else if (fastZombie.getX() < 0) {
                System.out.println("💀 FastZombie đã vượt qua hàng phòng thủ!");
                break;
            }

            round++;
        }

        System.out.println("\n🎮 Trò chơi kết thúc.");
    }
}
