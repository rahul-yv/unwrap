<?php

function hashPassword(string $password): string
{
    return password_hash($password, PASSWORD_DEFAULT);
}

function verifyPassword(string $password, string $hash): bool
{
    return password_verify($password, $hash);
}

$hash = hashPassword("hunter2");
assert(verifyPassword("hunter2", $hash));
assert(!verifyPassword("wrong-password", $hash));

echo "ok\n";
