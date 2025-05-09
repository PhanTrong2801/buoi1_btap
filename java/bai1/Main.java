package bai1;

import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<Student> students = new ArrayList<>();

        System.out.println("Nhập số lượng sinh viên: ");
        int n= Integer.parseInt(sc.nextLine());

        for (int i = 0; i < n; i++) {
            System.out.println("Sinh viên #" + (i + 1));
            System.out.print("ID: ");
            String id = sc.nextLine();
            System.out.print("Tên: ");
            String name = sc.nextLine();
            System.out.print("Tuổi: ");
            int age = Integer.parseInt(sc.nextLine());
            System.out.print("GPA: ");
            double gpa = Double.parseDouble(sc.nextLine());

            Student student = new Student(id, name, age, gpa);
            students.add(student);
        }


        // Hiển thị sinh viên có GPA >= 3.2
        System.out.println("Danh sách sinh viên có GPA >= 3.2:");
        for (Student s : students) {
            if (s.getGpa() >= 3.2) {
                s.display();
            }
        }

        // Sắp xếp sinh viên theo GPA giảm dần
        students.sort((a, b) -> Double.compare(b.getGpa(), a.getGpa()));

        // Hiển thị danh sách sau khi sắp xếp
        System.out.println("Danh sách sinh viên sau khi sắp xếp theo GPA giảm dần:");
        for (Student s : students) {
            s.display();
        }
    }
}
