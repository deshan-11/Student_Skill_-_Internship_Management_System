
<?php
require 'db.php';

$allowedTables = [
    'student',
    'department',
    'course',
    'enrollment',
    'skill',
    'skill_category',
    'student_skill',
    'skill_level',
    'certificate',
    'instructor',
    'training_program'
];

try {
    $result = [];

    foreach ($allowedTables as $table) {
        $stmt = $pdo->query("SELECT * FROM `$table`");
        $rows = $stmt->fetchAll();

        $result[$table] = [
            'columns' => array_keys($rows[0] ?? []),
            'rows' => $rows
        ];
    }

    echo json_encode([
        'success' => true,
        'tables' => $result
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Unable to load database tables.'
    ]);
}
