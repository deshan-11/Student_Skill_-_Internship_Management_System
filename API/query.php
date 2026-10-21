
<?php
require 'db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode([
        'success' => false,
        'message' => 'POST requests only.'
    ]);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);
$sql = trim($input['sql'] ?? '');

if ($sql === '' ||
    !preg_match('/^SELECT\b/i', $sql) ||
    str_contains($sql, ';') ||
    str_contains($sql, '--') ||
    str_contains($sql, '/*') ||
    preg_match('/\b(INTO|OUTFILE|DUMPFILE|FOR UPDATE|LOCK IN SHARE MODE)\b/i', $sql)) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => 'Only a single read-only SELECT query is allowed.'
    ]);
    exit;
}

try {
    $stmt = $pdo->query($sql);
    $rows = $stmt->fetchAll();

    echo json_encode([
        'success' => true,
        'columns' => array_keys($rows[0] ?? []),
        'rows' => $rows,
        'count' => count($rows)
    ]);
} catch (PDOException $e) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => 'SQL error: ' . $e->getMessage()
    ]);
}
