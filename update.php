<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $student_id = $_POST['student_id'];
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $email = $_POST['email'];
    $date_of_birth = $_POST['date_of_birth'];
    $gender = $_POST['gender'];
    $major = $_POST['major'];
    $enrollment_year = $_POST['enrollment_year'];

    // File upload
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
        
        $stmt = $conn->prepare("UPDATE students SET first_name = ?, last_name = ?, email = ?, date_of_birth = ?, gender = ?, major = ?, enrollment_year = ?, image_path = ? WHERE student_id = ?");
        $stmt->execute([$first_name, $last_name, $email, $date_of_birth, $gender, $major, $enrollment_year, $image_path, $student_id]);
        
        echo "Student record updated successfully";
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }
} else {
    $student_id = $_GET['id'];
    try {
        $conn = new PDO("mysql:host=localhost;dbname=tuqa-table", "root", "");
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        
        $query = "SELECT * FROM students WHERE student_id = ?";
        $stmt = $conn->prepare($query);
        $stmt->execute([$student_id]);
        $student = $stmt->fetch(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Student</title>
</head>
<body>
    <h2>Update Student Information</h2>
    <form action="update.php" method="post" enctype="multipart/form-data">
        <label for="student_id">Student ID:</label><br>
        <input type="number" id="student_id" name="student_id" value="<?php echo $student['student_id']; ?>" required readonly><br><br>
        
        <label for="first_name">First Name:</label><br>
        <input type="text" id="first_name" name="first_name" value="<?php echo $student['first_name']; ?>" required><br><br>
        
        <label for="last_name">Last Name:</label><br>
        <input type="text" id="last_name" name="last_name" value="<?php echo $student['last_name']; ?>" required><br><br>
        
        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" value="<?php echo $student['email']; ?>" required><br><br>
        
        <label for="date_of_birth">Date of Birth:</label><br>
        <input type="date" id="date_of_birth" name="date_of_birth" value="<?php echo $student['date_of_birth']; ?>" required><br><br>
        
        <label for="gender">Gender:</label><br>
        <select id="gender" name="gender" required>
            <option value="Male" <?php if ($student['gender'] == 'Male') echo 'selected'; ?>>Male</option>
            <option value="Female" <?php if ($student['gender'] == 'Female') echo 'selected'; ?>>Female</option>
        </select><br><br>
        
        <label for="major">Major:</label><br>
        <input type="text" id="major" name="major" value="<?php echo $student['major']; ?>"><br><br>
        
        <label for="enrollment_year">Enrollment Year:</label><br>
        <input type="number" id="enrollment_year" name="enrollment_year" value="<?php echo $student['enrollment_year']; ?>" min="2000" max="2100" required><br><br>
        
        <label for="image">Upload Image:</label><br>
        <input type="file" id="image" name="image" accept="image/*"><br><br>
        
        <input type="submit" value="Submit">
    </form>
</body>
</html>

<?php
}
?>
