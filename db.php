<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $first_name = htmlspecialchars($_POST['first_name']);
    $last_name = htmlspecialchars($_POST['last_name']);
    $email = htmlspecialchars($_POST['email']);
    $date_of_birth = htmlspecialchars($_POST['date_of_birth']);
    $gender = htmlspecialchars($_POST['gender']);
    $major = htmlspecialchars($_POST['major']);
    $enrollment_year = htmlspecialchars($_POST['enrollment_year']);

    // Handle image upload
    if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
        $target_dir = "uploads/";
        $image_path = $target_dir . basename($_FILES['image']['name']);
        move_uploaded_file($_FILES['image']['tmp_name'], $image_path);
    } else {
        $image_path = "";
    }

    try {
        $conn = new PDO("mysql:host=localhost;dbname=tuqa-table", "root", "");
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $stmt = $conn->prepare("INSERT INTO students (first_name, last_name, email, date_of_birth, gender, major, enrollment_year, image_path) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([
            $first_name,
            $last_name,
            $email,
            $date_of_birth,
            $gender,
            $major,
            $enrollment_year,
            $image_path
        ]);

        echo "New student record created successfully";
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }
}
?>
