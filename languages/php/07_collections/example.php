<?php

$numbers = [1, 2, 3, 4, 5];

$doubled = array_map(fn($n) => $n * 2, $numbers);
assert($doubled === [2, 4, 6, 8, 10]);

$evens = array_filter($numbers, fn($n) => $n % 2 === 0);
assert($evens === [1 => 2, 3 => 4]);

$total = array_reduce($numbers, fn($acc, $n) => $acc + $n, 0);
assert($total === 15);

$ages = ["Ada" => 36, "Grace" => 85];
$adaAge = $ages["Ada"] ?? null;
assert($adaAge === 36);
assert(($ages["Nobody"] ?? null) === null);

$evensReindexed = array_values($evens);
assert($evensReindexed === [2, 4]);

echo "ok\n";
