<?php
$student_id = $_GET['id'];

echo "<script>
    if (confirm('Are you sure you want to delete this student?')) {
        window.location.href = 'soft_delete.php?id={$student_id}';
    } else {
        window.location.href = 'index.php';
    }
</script>";
?>

<!-- soft_delete.php -->
<?php
$student_id = $_GET['id'];

try {
    $conn = new PDO("mysql:host=localhost;dbname=tuqa-table", "root", "");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $stmt = $conn->prepare("UPDATE students SET deleted_at = NOW() WHERE student_id = ?");
    $stmt->execute([$student_id]);
    
    echo "Student record soft deleted successfully";
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
