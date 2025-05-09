package bai2;

import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        ArrayList<Employee> employees = new ArrayList<>();

        // Thêm nhân viên Full-time
        employees.add(new FullTimeEmployee("FT001", "Nguyễn Văn A", 15000000));
        employees.add(new FullTimeEmployee("FT002", "Trần Thị B", 18000000));

        // Thêm nhân viên Part-time
        employees.add(new PartTimeEmployee("PT001", "Lê Văn C", 100, 50000));
        employees.add(new PartTimeEmployee("PT002", "Phạm Thị D", 80, 55000));

        double totalSalary = 0;

        System.out.println("Danh sách nhân viên và lương:");
        for (Employee e : employees) {
            e.display();
            totalSalary += e.calculateSalary();
        }

        System.out.printf("Tổng lương công ty phải trả: %.2f VND%n", totalSalary);
    }

}
