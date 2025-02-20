/* Database Design */

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    major VARCHAR(100) DEFAULT NULL,
    enrollment_year YEAR NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    credits INT NOT NULL CHECK (credits > 0),
    department VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    hire_date DATE NOT NULL,
    department VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE CourseAssignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    instructor_id INT,
    course_id INT,
    semester ENUM('Spring', 'Summer', 'Fall', 'Winter') NOT NULL,
    year YEAR(4) NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/* Add Index */
CREATE INDEX idx_course_code ON Courses(course_code);

/* Functions, Stored Procedures, Constraints, and Transactions */

/* Function to calculate a student's age based on date_of_birth */
CREATE FUNCTION CalculateAge(@date_of_birth DATE)
RETURNS INT
AS
BEGIN
    DECLARE @age INT;
    SET @age = DATEDIFF(YEAR, @date_of_birth, GETDATE()) -
               CASE WHEN MONTH(@date_of_birth) > MONTH(GETDATE()) 
                       OR (MONTH(@date_of_birth) = MONTH(GETDATE()) 
                           AND DAY(@date_of_birth) > DAY(GETDATE())) 
                    THEN 1 ELSE 0 END;
    RETURN @age;
END;

/* Stored procedure to enroll a student in a course */
CREATE PROCEDURE EnrollStudent
    @student_id INT,
    @course_id INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Enrollments WHERE student_id = @student_id AND course_id = @course_id)
    BEGIN
        INSERT INTO Enrollments (student_id, course_id)
        VALUES (@student_id, @course_id);
    END
    ELSE
    BEGIN
        PRINT 'Student is already enrolled in this course.';
    END
END;

/* Add a constraint to ensure unique student emails */
ALTER TABLE Students
ADD CONSTRAINT unique_student_email UNIQUE (email);

/* Write a transaction to enroll a student if the course capacity isn't exceeded */
CREATE PROCEDURE EnrollStudentWithCapacityCheck
    @student_id INT,
    @course_id INT
AS
BEGIN
    BEGIN TRANSACTION;

    DECLARE @current_enrollment INT;
    DECLARE @course_capacity INT;
    DECLARE @already_enrolled BIT;
    
    SELECT @current_enrollment = COUNT(*)
    FROM Enrollments
    WHERE course_id = @course_id;

    SELECT @course_capacity = capacity
    FROM Courses
    WHERE course_id = @course_id;
    
    SELECT @already_enrolled = CASE WHEN EXISTS (SELECT 1 FROM Enrollments WHERE student_id = @student_id AND course_id = @course_id) THEN 1 ELSE 0 END;
    
    IF @already_enrolled = 1
    BEGIN
        PRINT 'Student is already enrolled in this course.';
        ROLLBACK TRANSACTION;
    END
    ELSE IF @current_enrollment < @course_capacity
    BEGIN
        INSERT INTO Enrollments (student_id, course_id)
        VALUES (@student_id, @course_id);

        COMMIT TRANSACTION;
    END
    ELSE
    BEGIN
        PRINT 'Course capacity has been exceeded.';
        ROLLBACK TRANSACTION;
    END
END;

/* Use aggregate functions to show average grades by department */
SELECT d.department_name, AVG(g.grade) AS average_grade
FROM Grades g
JOIN Courses c ON g.course_id = c.course_id
JOIN Departments d ON c.department_id = d.department_id
GROUP BY d.department_name;

/* Insert Data */
INSERT INTO Students (first_name, last_name, email, date_of_birth, gender, major, enrollment_year) VALUES
('John', 'Doe', 'john.doe@example.com', '2000-05-15', 'M', 'Computer Science', 2022),
('Jane', 'Smith', 'jane.smith@example.com', '2001-03-22', 'F', 'Mathematics', 2021),
('Alice', 'Johnson', 'alice.johnson@example.com', '2002-07-08', 'F', 'Physics', 2023),
('Bob', 'Brown', 'bob.brown@example.com', '1999-12-30', 'M', 'Chemistry', 2020),
('Charlie', 'Davis', 'charlie.davis@example.com', '2000-10-11', 'M', 'Biology', 2022),
('Eve', 'Wilson', 'eve.wilson@example.com', '2001-06-18', 'F', 'History', 2021),
('Frank', 'Moore', 'frank.moore@example.com', '2002-09-25', 'M', 'Literature', 2023),
('Grace', 'Taylor', 'grace.taylor@example.com', '1999-11-03', 'F', 'Art', 2020),
('Hank', 'Anderson', 'hank.anderson@example.com', '2000-08-29', 'M', 'Engineering', 2022),
('Ivy', 'Thomas', 'ivy.thomas@example.com', '2001-02-14', 'F', 'Philosophy', 2021);

INSERT INTO Instructors (first_name, last_name, email, hire_date, department) VALUES
('Dr. Alan', 'Turing', 'alan.turing@example.com', '2010-01-10', 'Computer Science'),
('Dr. Marie', 'Curie', 'marie.curie@example.com', '2012-05-20', 'Physics'),
('Dr. Isaac', 'Newton', 'isaac.newton@example.com', '2008-09-15', 'Mathematics'),
('Dr. Charles', 'Darwin', 'charles.darwin@example.com', '2015-03-25', 'Biology'),
('Dr. Ada', 'Lovelace', 'ada.lovelace@example.com', '2011-11-30', 'Engineering');

INSERT INTO Courses (course_name, course_code, credits, department) VALUES
('Introduction to Computer Science', 'CS101', 4, 'Computer Science'),
('Calculus I', 'MATH101', 3, 'Mathematics'),
('General Physics', 'PHYS101', 4, 'Physics'),
('Organic Chemistry', 'CHEM101', 3, 'Chemistry'),
('Biology Basics', 'BIO101', 4, 'Biology');

INSERT INTO course_assignments (instructor_id, course_id, semester, year) VALUES
(1, 1, 'Fall', 2024),
(3, 2, 'Fall', 2024),
(2, 3, 'Fall', 2024),
(4, 5, 'Fall', 2024),
(5, 4, 'Fall', 2024);

INSERT INTO Enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 3, 'A-'),
(2, 5, 'B+'),
(3, 3, 'B'),
(3, 1, 'A+'),
(4, 4, 'C'),
(4, 2, 'B'),
(5, 5, 'B+'),
(5, 3, 'A'),
(6, 1, 'A-'),
(6, 4, 'B'),
(7, 2, 'B+'),
(7, 5, 'A'),
(8, 3, 'B-'),
(8, 4, 'B+'),
(9, 1, 'A'),
(9, 2, 'A-'),
(10, 5, 'B'),
(10, 3, 'A');

ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `course_assignments`
  ADD CONSTRAINT

  /* op */
CREATE INDEX idx_course_code ON Courses(course_code);

/*  Create indexes on student_id and course_id in Enrollments*/
 CREATE INDEX idx_student_id ON Enrollments(student_id);
CREATE INDEX idx_course_id ON Enrollments(course_id);

EXPLAIN
SELECT s.student_id, s.first_name, s.last_name, e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_code = 'CS101';


/* an inner join to fetch students and the courses they are enrolled in.*/

SELECT s.student_id, s.first_name, s.last_name, c.course_name, c.course_code
FROM Students s
INNER JOIN Enrollments e ON s.student_id = e.student_id
INNER JOIN Courses c ON e.course_id = c.course_id;


/* a left join to show instructors and courses they teach */
SELECT i.instructor_id, i.first_name, i.last_name, c.course_name, c.course_code
FROM Instructors i
LEFT JOIN course_assignments ca ON i.instructor_id = ca.instructor_id
LEFT JOIN Courses c ON ca.course_id = c.course_id;


/* a query using union to list all students and instructors */
SELECT first_name, last_name, 'Student' AS role
FROM Students
UNION
SELECT first_name, last_name, 'Instructor' AS role
FROM Instructors;




/*  generate a report*/

SELECT 
    s.first_name AS student_first_name,
    s.last_name AS student_last_name,
    s.email AS student_email,
    s.major AS student_major,
    c.course_name AS course_name,
    i.first_name AS instructor_first_name,
    i.last_name AS instructor_last_name,
    e.grade AS student_grade,
    c.credits AS course_credits,
    (SELECT SUM(c1.credits) 
     FROM Enrollments e1 
     JOIN Courses c1 ON e1.course_id = c1.course_id 
     WHERE e1.student_id = s.student_id) AS total_credits
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN course_assignments ca ON c.course_id = ca.course_id
JOIN Instructors i ON ca.instructor_id = i.instructor_id
ORDER BY s.student_id, c.course_name;
