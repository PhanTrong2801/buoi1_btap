package org.example.bai4;

public class Main {
    public static void main(String[] args) throws IllegalAccessException {
        Shape shape1 = ShapeFactory.getShape("circle");
        shape1.draw(); // Kết quả: Vẽ hình tròn.

        Shape shape2 = ShapeFactory.getShape("square");
        shape2.draw();
    }
}
