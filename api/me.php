<?php
declare(strict_types=1);
require_once __DIR__ . '/auth.php';
echo json_encode(['success' => true, 'user' => require_login()]);
