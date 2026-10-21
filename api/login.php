<?php
declare(strict_types=1);
require_once __DIR__ . '/db.php';
if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start();
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'POST requests only.']);
    exit;
}
$data = json_decode(file_get_contents('php://input'), true);
$email = strtolower(trim($data['email'] ?? ''));

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Enter a valid email address.']);
    exit;
}

$user = null;
$stmt = $pdo->prepare("SELECT Student_ID AS id, CONCAT(First_Name, ' ', Last_Name) AS name FROM Student WHERE LOWER(Email) = ?");
$stmt->execute([$email]);
if ($row = $stmt->fetch()) {
    $user = ['role' => 'student', 'id' => $row['id'], 'name' => $row['name'], 'email' => $email];
}

if (!$user) {
    $stmt = $pdo->prepare("SELECT Instructor_ID AS id, Instructor_Name AS name FROM Instructor WHERE LOWER(Email) = ?");
    $stmt->execute([$email]);
    if ($row = $stmt->fetch()) {
        $user = ['role' => 'instructor', 'id' => $row['id'], 'name' => $row['name'], 'email' => $email];
    }
}

if (!$user) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'This email is not registered as a student or instructor.']);
    exit;
}

session_regenerate_id(true);
$_SESSION['user'] = $user;
echo json_encode(['success' => true, 'user' => $user]);
