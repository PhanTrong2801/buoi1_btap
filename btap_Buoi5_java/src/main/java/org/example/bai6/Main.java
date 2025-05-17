package org.example.bai6;

public class Main {
    public static void main(String[] args) {
        // Đăng ký các class vào Factory
        ProductFactory.register("phone", Phone::new);
        ProductFactory.register("laptop", Laptop::new);

        // Tạo và sử dụng các đối tượng
        Product phone = ProductFactory.create("phone");
        phone.use();

        Product laptop = ProductFactory.create("laptop");
        laptop.use();
    }
}
