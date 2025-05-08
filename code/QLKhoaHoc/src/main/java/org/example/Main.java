package org.example;

import java.util.ArrayList;
import java.util.Scanner;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);
        ArrayList<Student> studentList = new ArrayList<>();
        ArrayList<Course> courseList = new ArrayList<>();

        int choice;

        do {
            System.out.println("\n===== MENU =====");
            System.out.println("1. Them sinh vien");
            System.out.println("2. Them khoa hoc");
            System.out.println("3.Dang ki khoa hoc");
            System.out.println("4. In danh sach SV trong khoa hoc (theo ngay dang ky)");
            System.out.println("5. In khoa hoc ma sinh vien da dang ky");
            System.out.println("0. Thoat");
            System.out.print("Chon chuc nang: ");
            choice = Integer.parseInt(scanner.nextLine());

            switch (choice) {
                case 1:
                    Student newStudent = inputStudent(scanner);
                    studentList.add(newStudent);
                    System.out.println("Da them sinh vien: " + newStudent);
                    break;

                case 2:
                    Course newCourse = inputCourse(scanner);
                    courseList.add(newCourse);
                    System.out.println("Da them khoa hoc: " + newCourse);
                    break;

                case 3:
                    if(studentList.isEmpty()||courseList.isEmpty()){
                        System.out.println("Chua co du lieu sinh vien hoac khoa hoc");
                        break;
                    }

                    System.out.println("Danh sach sinh vien: ");
                    for (int i=0;i<studentList.size();i++){
                        System.out.println((i+1)+"."+studentList.get(i));
                    }

                    System.out.println("Chon sinh vien:");
                    int studentIndex= Integer.parseInt(scanner.nextLine())-1;

                    System.out.println("Danh sach khoa hoc:");
                    for (int i=0;i<courseList.size();i++){
                        System.out.println((i+1)+"."+courseList.get(i));
                    }
                    System.out.println("Chon khoa hoc:");
                    int courseIndex= Integer.parseInt(scanner.nextLine())-1;

                    if(studentIndex >=0 && studentIndex<studentList.size()
                        &&courseIndex >=0 && courseIndex<courseList.size()){

                        Student selectedStudent = studentList.get(studentIndex);
                        Course selectedCourse = courseList.get(courseIndex);
                        selectedCourse.enrollStudent(selectedStudent);
                    }else{
                        System.out.println("Lua chon khong hop le!");
                    }
                    break;

                case 4:
                    if(courseList.isEmpty()){
                        System.out.println("Chua co khoa hoc nao!");
                        break;
                    }
                    System.out.println("Danh sach khoa hoc:");
                    for (int i=0;i<courseList.size();i++){
                        System.out.println((i+1)+"."+ courseList.get(i).getTitle());
                    }
                    System.out.println("Chon khoa hoc:");
                    int index = Integer.parseInt(scanner.nextLine())-1;

                    if(index>=0 && index <courseList.size()){
                        Course selectedCourse = courseList.get(index);
                        System.out.println("==Danh sach sinh vien da dang ki (sap theo ngay):====");
                        selectedCourse.printEnrolledStuentsSortedByDate();
                    }else {
                        System.out.println("Lua chon khong hop le!");
                    }
                    break;

                case 5:
                    printCoursesOfStudent(scanner, studentList, courseList);
                    break;


                case 0:
                    System.out.println("Tam biet!");
                    break;

                default:
                    System.out.println(" Lua chon khong hop le.");
            }

        } while (choice != 0);

    }

    private static Course inputCourse(Scanner scanner) {
        System.out.print("Nhap ma khoa hoc: ");
        String id = scanner.nextLine();

        System.out.print("Nhap ten khoa hoc: ");
        String title = scanner.nextLine();

        System.out.print("Nhap so luong sinh vien toi da: ");
        int max = Integer.parseInt(scanner.nextLine());

        return new Course(id, title, max);
    }

    private static Student inputStudent(Scanner scanner) {
        System.out.print("Nhap ma sinh vien: ");
        String id = scanner.nextLine();

        System.out.print("Nhap ho ten: ");
        String name = scanner.nextLine();

        System.out.print("Nhap email: ");
        String email = scanner.nextLine();

        return new Student(id, name, email);
    }

    private static void printCoursesOfStudent(Scanner scanner, ArrayList<Student> students, ArrayList<Course> courses) {
        if (students.isEmpty() || courses.isEmpty()) {
            System.out.println("Chua co du lieu sinh vien hoac khoa hoc.");
            return;
        }

        System.out.println("Danh sach sinh vien:");
        for (int i = 0; i < students.size(); i++) {
            System.out.println((i + 1) + ". " + students.get(i));
        }

        System.out.print("Chon sinh vien (so thu tu): ");
        int studentIndex = Integer.parseInt(scanner.nextLine()) - 1;

        if (studentIndex < 0 || studentIndex >= students.size()) {
            System.out.println(" Lua chon khong hop le.");
            return;
        }

        Student selectedStudent = students.get(studentIndex);
        System.out.println("=== Danh sach khoa hoc da dang ky ===");

        boolean found = false;
        for (Course course : courses) {
            for (Enrollment e : course.getEnrollments()) {
                if (e.getStudent().getId().equals(selectedStudent.getId())) {
                    System.out.println(course.getTitle() + " (Dang ky ngay: " + e.getDate() + ")");
                    found = true;
                }
            }
        }

        if (!found) {
            System.out.println("⚠️ Sinh vien chua dang ky khoa hoc nao.");
        }
    }


}