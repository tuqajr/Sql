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
    
    $stmt = $conn->prepare("INSERT INTO students (first_name, last_name, email, date_of_birth, gender, major, enrollment_year, timestamp) 
    VALUES (?, ?, ?, ?, ?, ?, ?, NOW())");
    $stmt->execute([$first_name, $last_name, $email, $date_of_birth, $gender, $major, $enrollment_year]);
    
    echo "New student record created successfully";
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
