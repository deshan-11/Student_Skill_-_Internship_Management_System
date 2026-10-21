<?php
session_start();
header('Content-Type: application/json; charset=utf-8');

function require_login(): array {
    if (empty($_SESSION['user'])) {
        http_response_code(401);
        echo json_encode(['success' => false, 'message' => 'Please sign in first.']);
        exit;
    }
    return $_SESSION['user'];
}