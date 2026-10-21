<?php
require 'db.php';
require 'auth.php';
require_login();

$allowedTables = [
    'Student', 'Department', 'Course', 'Enrollment', 'Skill', 'Skill_Category',
    'Student_Skill', 'Skill_Level', 'Certificate', 'Instructor', 'Training_Program'
];

try {
    $result = [];
    foreach ($allowedTables as $table) {
        $rows = $pdo->query("SELECT * FROM `$table`")->fetchAll();
        $result[strtolower($table)] = [
            'columns' => array_keys($rows[0] ?? []),
            'rows'    => $rows
        ];
    }
    echo json_encode(['success' => true, 'tables' => $result]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Unable to load database tables.']);
}