<?php
try {
    $conn = new PDO("mysql:host=localhost;dbname=tuqa-table", "root", "");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    if (isset($_GET['id'])) {
        $student_id = $_GET['id'];

        // Use a DELETE statement
        $stmt = $conn->prepare("DELETE FROM students WHERE student_id = :student_id");

        // Bind the named parameter
        $stmt->bindParam(':student_id', $student_id);

        // Execute the statement
        $stmt->execute();

        echo "Student deleted successfully.";
        header("Location: index.php");
        exit;
    }
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
