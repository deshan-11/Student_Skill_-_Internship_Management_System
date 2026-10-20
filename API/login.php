
<?php
session_start();
header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false]);
    exit;
}

$data = json_decode(file_get_contents('php://input'), true);

$username = $data['username'] ?? '';
$password = $data['password'] ?? '';

// Demo login only. Replace with stored users
// and password_hash/password_verify before deployment.
if ($username === 'admin' && $password === '1234') {
    session_regenerate_id(true);
    $_SESSION['student_skills_admin'] = true;

    echo json_encode(['success' => true]);
} else {
    http_response_code(401);
    echo json_encode([
        'success' => false,
        'message' => 'Invalid username or password.'
    ]);
}

