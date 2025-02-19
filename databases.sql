/* Database Design */

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
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


ALTER TABLE `courseassignments`
  ADD PRIMARY KEY (`assignment_id`),
  ADD KEY `instructor_id` (`instructor_id`),
  ADD KEY `course_id` (`course_id`);

ALTER TABLE `courses`

CREATE TABLE `courseassignments` (
  `assignment_id` int(11) NOT NULL AUTO_INCREMENT,
  `instructor_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `semester` enum('Spring','Summer','Fall','Winter') NOT NULL,
  `year` year(4) NOT NULL,
  PRIMARY KEY (`assignment_id`),
  KEY `instructor_id` (`instructor_id`),
  KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_name` varchar(100) NOT NULL,
  `course_code` varchar(20) NOT NULL UNIQUE,
  `credits` int(11) NOT NULL CHECK (`credits` > 0),
  `department` varchar(100) NOT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `enrollments` (
  `enrollment_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `grade` char(2) DEFAULT NULL,
  PRIMARY KEY (`enrollment_id`),
  KEY `student_id` (`student_id`),
  KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `instructors` (
  `instructor_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL UNIQUE,
  `hire_date` date NOT NULL,
  `department` varchar(100) NOT NULL,
  PRIMARY KEY (`instructor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL UNIQUE,
  `date_of_birth` date NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `major` varchar(100) DEFAULT NULL,
  `enrollment_year` year(4) NOT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `courseassignments`
  ADD CONSTRAINT `courseassignments_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`instructor_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `courseassignments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;
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

INSERT INTO CourseAssignments (instructor_id, course_id, semester, year) VALUES
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


ALTER TABLE `courseassignments`
  ADD CONSTRAINT `courseassignments_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`instructor_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `courseassignments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;


ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;
COMMIT;

/* Basic Queries */
SELECT * FROM students;

SELECT COUNT(*) AS total_courses FROM courses;


SELECT s.first_name, s.last_name 
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE e.course_id = 1;  

SELECT email 
FROM instructors
WHERE department = 'Computer Science';  


/* Intermediate Queries */
SELECT c.course_name, COUNT(e.student_id) AS num_students
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id;

SELECT s.first_name, s.last_name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.grade = 'A';

SELECT c.course_name, i.first_name AS instructor_first_name, i.last_name AS instructor_last_name
FROM courseassignments ca
JOIN courses c ON ca.course_id = c.course_id
JOIN instructors i ON ca.instructor_id = i.instructor_id
WHERE ca.semester = 'Summer' AND ca.year = 2025;  

SELECT c.course_name, AVG(
    CASE 
        WHEN e.grade = 'A' THEN 4.0
        WHEN e.grade = 'B+' THEN 3.5
        WHEN e.grade = 'B' THEN 3.0
        WHEN e.grade = 'C+' THEN 2.5
        WHEN e.grade = 'C' THEN 2.0
        WHEN e.grade = 'D+' THEN 1.5
        WHEN e.grade = 'D' THEN 1.0
        WHEN e.grade = 'F' THEN 0.0
        ELSE NULL 
    END
) AS average_grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
ORDER BY average_grade DESC
LIMIT 1;


SELECT c.department, COUNT(c.course_id) AS num_courses
FROM courses c
JOIN courseassignments ca ON c.course_id = ca.course_id
WHERE ca.year = 2025  
ORDER BY num_courses DESC
LIMIT 1;


SELECT c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.student_id IS NULL;


/* Advanced Queries */
SELECT s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN CourseAssignments ca ON e.course_id = ca.course_id
WHERE ca.semester = 'Fall' AND ca.year = 2025
GROUP BY s.student_id
HAVING COUNT(e.course_id) > 3;

SELECT s.first_name, s.last_name, e.course_id, e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.grade IS NULL OR e.grade = '';

SELECT s.first_name, s.last