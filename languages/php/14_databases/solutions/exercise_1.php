<?php

function getUserName(PDO $pdo, int $id): ?string
{
    $stmt = $pdo->prepare("SELECT name FROM users WHERE id = ?");
    $stmt->execute([$id]);
    $name = $stmt->fetchColumn();
    return $name === false ? null : $name;
}

$pdo = new PDO("sqlite::memory:");
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$pdo->exec("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");

$stmt = $pdo->prepare("INSERT INTO users (name) VALUES (?)");
$stmt->execute(["Ada"]);

assert(getUserName($pdo, 1) === "Ada");
assert(getUserName($pdo, 999) === null);

echo "ok\n";
