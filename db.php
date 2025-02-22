<?php
$first_name = $_POST['first_name'];
 $last_name = $_POST['last_name'];
 $email = $_POST['email'];
 $date_of_birth = $_POST['date_of_birth'];
 $gender = $_POST['gender'];
 $major = $_POST['major'];
 $enrollment_year = $_POST['enrollment_year'];

 try {
     $conn = new PDO("mysql:host=localhost;dbname=tuqa-table", "root", "");
     $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

     $stmt = $conn->prepare("INSERT INTO students (first_name, last_name, email, date_of_birth, gender, major, enrollment_year) 
     VALUES (?, ?, ?, ?, ?, ?, ?)");
     $stmt->execute([
         $first_name,
         $last_name,
         $email,
         $date_of_birth,
         $gender,
         $major,
       $enrollment_year
    ]);

     echo "New student record created successfully";
 } catch (PDOException $e) {
     echo "Error: " . $e->getMessage();
 }

 ini_set('display_errors', 1);
 ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student</title>
</head>
<body>
    <h2>Student Information</h2>
    <form action="./tt_db.php" method="post">
        <label for="student_id">Student ID:</label><br>
        <input type="number" id="student_id" name="student_id" required><br><br>
        
        <label for="first_name">First Name:</label><br>
        <input type="text" id="first_name" name="first_name" required><br><br>
        
        <label for="last_name">Last Name:</label><br>
        <input type="text" id="last_name" name="last_name" required><br><br>
        
        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" required><br><br>
        
        <label for="date_of_birth">Date of Birth:</label><br>
        <input type="date" id="date_of_birth" name="date_of_birth" required><br><br>
        
        <label for="gender">Gender:</label><br>
        <select id="gender" name="gender" required>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select><br><br>
        
        <label for="major">Major:</label><br>
        <input type="text" id="major" name="major"><br><br>
        
        <label for="enrollment_year">Enrollment Year:</label><br>
        <input type="number" id="enrollment_year" name="enrollment_year" min="2000" max="2100" required><br><br>
        
        <input type="submit" value="Submit">
    </form>
</body>
</html>