<?php

$hash = password_hash("hunter2", PASSWORD_DEFAULT);

$matches = password_verify("hunter2", $hash);
assert($matches === true);

$wrong = password_verify("wrong-password", $hash);
assert($wrong === false);

$token = bin2hex(random_bytes(16));
assert(strlen($token) === 32);

$a = "expected-value";
$b = "expected-value";
$safeCompare = hash_equals($a, $b);
assert($safeCompare === true);
assert(hash_equals($a, "different-value") === false);

echo "ok\n";
