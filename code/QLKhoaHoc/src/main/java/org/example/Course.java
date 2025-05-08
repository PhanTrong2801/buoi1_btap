package org.example;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Course {
    private String id;
    private  String title;
    private int maxStudents;

    ArrayList<Enrollment> enrollments = new ArrayList<>();

    public ArrayList<Enrollment> getEnrollments() {
        return enrollments;
    }


    public Course(String id, String title, int maxStudents) {
        this.id = id;
        this.title = title;
        this.maxStudents = maxStudents;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getMaxStudents() {
        return maxStudents;
    }

    public void setMaxStudents(int maxStudents) {
        this.maxStudents = maxStudents;
    }


    public boolean isFull() {
        return enrollments.size() >= maxStudents;
    }

    public boolean enrollStudent(Student student) {
        if (isFull()) {
            System.out.println(" Khoa hoc da day.");
            return false;
        }

        // Kiểm tra xem sinh viên đã đăng ký
        for (Enrollment e : enrollments) {
            if (e.getStudent().getId().equals(student.getId())) {
                System.out.println(" Sinh vien da dang ky khoa hoc nay.");
                return false;
            }
        }

        enrollments.add(new Enrollment(student,this, LocalDate.now()));
        System.out.println(" Dang ky thanh cong.");
        return true;
    }


    @Override
    public String toString() {
        return "Course{" +
                "id='" + id + '\'' +
                ", title='" + title + '\'' +
                ", maxStudents=" + maxStudents +
                ", enrollments=" + enrollments +
                '}';
    }

    public void printEnrolledStuentsSortedByDate(){
        enrollments.stream()
                .sorted((e1,e2) ->e1.getDate().compareTo(e2.getDate()))
                .forEach(e->{
                    System.out.println(e.getStudent() + "- Ngay dang ki:" +e.getDate());
                });
    }

}
