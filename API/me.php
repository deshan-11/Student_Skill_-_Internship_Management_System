<?php
require 'auth.php';
echo json_encode(['success' => true, 'user' => require_login()]);