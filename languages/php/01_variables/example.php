<?php

$age = 25;
$name = "Ada";
$age = $age + 1;
assert($age === 26);
assert($name === "Ada");

const MAX_RETRIES = 3;
assert(MAX_RETRIES === 3);

$point = [3, 4];
$copy = $point;
$copy[0] = 99;
assert($point === [3, 4]);
assert($copy === [99, 4]);

echo "ok\n";
