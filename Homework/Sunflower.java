package Homework;

public class Sunflower extends GameObject{
    private int energyGenerated;

    public Sunflower(int x, int y) {
        super(80, x, y); // máu thấp hơn
        this.energyGenerated = 0;
    }

    @Override
    public void update() {
        energyGenerated += 25;
        System.out.println("Sunflower tạo ra 25 năng lượng (tổng: " + energyGenerated + ")");
    }

    public int getEnergyGenerated() {
        return energyGenerated;
    }
}
