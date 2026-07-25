<?php

$sum = 3 + 4;
$remainder = 10 % 3;
assert($sum === 7 && $remainder === 1);

$greeting = "Hello, " . "world";
assert($greeting === "Hello, world");

$a = ["x" => 1, "y" => 2];
$b = ["y" => 99, "z" => 3];
$union = $a + $b;
assert($union === ["x" => 1, "y" => 2, "z" => 3]);

$cmp = 3 <=> 5;
assert($cmp === -1);

$items = [["age" => 30], ["age" => 20], ["age" => 25]];
usort($items, fn($a, $b) => $a["age"] <=> $b["age"]);
assert(array_column($items, "age") === [20, 25, 30]);

$config = [];
$config["retries"] ??= 3;
assert($config["retries"] === 3);
$config["retries"] ??= 99;
assert($config["retries"] === 3);

echo "ok\n";
