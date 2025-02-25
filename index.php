<?php
$students = [];

try {
    $conn = new PDO("mysql:host=localhost;dbname=tuqa-table", "root", "");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Database connection successful.<br>"; // Debugging message
    
    $stmt = $conn->prepare("SELECT * FROM students");
    $stmt->execute();
    $students = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($students) {
        echo "Data fetched successfully.<br>"; // Debugging message
    } else {
        echo "No data found.<br>"; // Debugging message
    }
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management</title>
</head>
<body>
    <h2>Student Management</h2>
    <a href="form.php">Add New Student</a>
    <table border="1">
        <tr>
            <th>Student ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Date of Birth</th>
            <th>Gender</th>
            <th>Major</th>
            <th>Enrollment Year</th>
            <th>Image</th>
            <th>Actions</th>
        </tr>
        <?php if (!empty($students)): ?>
            <?php foreach ($students as $student): ?>
            <tr>
                <td><?php echo htmlspecialchars($student['student_id']); ?></td>
                <td><?php echo htmlspecialchars($student['first_name']); ?></td>
                <td><?php echo htmlspecialchars($student['last_name']); ?></td>
                <td><?php echo htmlspecialchars($student['email']); ?></td>
                <td><?php echo htmlspecialchars($student['date_of_birth']); ?></td>
                <td><?php echo htmlspecialchars($student['gender']); ?></td>
                <td><?php echo htmlspecialchars($student['major']); ?></td>
                <td><?php echo htmlspecialchars($student['enrollment_year']); ?></td>
                <td>
                    <?php if (!empty($student['image_path'])): ?>
                        <img src="<?php echo htmlspecialchars($student['image_path']); ?>" alt="Student Image" width="100">
                    <?php else: ?>
                        No Image
                    <?php endif; ?>
                </td>
                <td>
                    <a href="update.php?id=<?php echo htmlspecialchars($student['student_id']); ?>">Update</a>
                    <a href="delete.php?id=<?php echo htmlspecialchars($student['student_id']); ?>">Delete</a>
                </td>
            </tr>
            <?php endforeach; ?>
        <?php else: ?>
            <tr>
                <td colspan="10">No students found.</td>
            </tr>
        <?php endif; ?>
    </table>
</body>
</html>
