<?php

function describe(mixed $value): string
{
    return match (true) {
        is_int($value) => "an int: $value",
        is_string($value) => "a string of length " . strlen($value),
        default => "something else",
    };
}

$age = 20;
$category = $age < 13 ? "child" : ($age < 20 ? "teen" : "adult");
assert($category === "adult");

$x = 5;
$description = match (true) {
    $x < 0 => "negative",
    $x === 0 => "zero",
    $x % 2 === 0 => "positive even",
    default => "positive odd",
};
assert($description === "positive odd");

assert(describe(42) === "an int: 42");
assert(describe("hi") === "a string of length 2");

echo "ok\n";
