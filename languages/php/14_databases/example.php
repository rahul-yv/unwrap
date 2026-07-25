<?php

$pdo = new PDO("sqlite::memory:");
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$pdo->exec("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");

$stmt = $pdo->prepare("INSERT INTO users (name) VALUES (?)");
$stmt->execute(["Ada"]);

$stmt = $pdo->prepare("SELECT name FROM users WHERE id = ?");
$stmt->execute([1]);
$name = $stmt->fetchColumn();
assert($name === "Ada");

$stmt = $pdo->prepare("SELECT name FROM users WHERE id = ?");
$stmt->execute([999]);
$missing = $stmt->fetchColumn();
assert($missing === false);

echo "ok\n";
