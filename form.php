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
