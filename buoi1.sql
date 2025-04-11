CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    gpa DECIMAL(3,2) CHECK (gpa BETWEEN 0.0 AND 4.0)
);

CREATE TABLE Professors (
    professor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT CHECK (credits BETWEEN 1 AND 5) NOT NULL,
    professor_id INT NOT NULL,
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id)
);
CREATE TABLE Enrollments (
    student_id INT,
    course_id INT,
    enroll_date DATE NOT NULL,
    grade INT CHECK (grade BETWEEN 1 AND 20),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE

