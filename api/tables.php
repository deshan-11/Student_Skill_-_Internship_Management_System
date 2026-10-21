<?php
declare(strict_types=1);
require_once __DIR__ . '/db.php';
require_once __DIR__ . '/auth.php';
require_login();

$allowedTables = [
    'Student', 'Department', 'Course', 'Enrollment', 'Skill',
    'Skill_Category', 'Student_Skill', 'Skill_Level', 'Certificate',
    'Instructor', 'Training_Program'
];

try {
    $result = [];
    foreach ($allowedTables as $table) {
        $rows = $pdo->query("SELECT * FROM `{$table}`")->fetchAll();
        $columns = $rows ? array_keys($rows[0]) : [];
        if (!$columns) {
            $stmt = $pdo->query("SELECT * FROM `{$table}` LIMIT 0");
            for ($i = 0; $i < $stmt->columnCount(); $i++) {
                $meta = $stmt->getColumnMeta($i);
                $columns[] = $meta['name'] ?? '';
            }
        }
        $result[strtolower($table)] = ['columns' => $columns, 'rows' => $rows];
    }
    echo json_encode(['success' => true, 'tables' => $result], JSON_INVALID_UTF8_SUBSTITUTE);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Unable to load database tables. Check table names in your database.']);
}
