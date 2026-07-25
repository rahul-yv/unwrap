<?php

function greet(string $name, string $greeting = "Hello"): string
{
    return "$greeting, $name!";
}

function sum(int ...$numbers): int
{
    return array_sum($numbers);
}

function makeCounter(): callable
{
    $count = 0;
    return function () use (&$count) {
        return ++$count;
    };
}

assert(greet("Ada") === "Hello, Ada!");
assert(greet("Ada", greeting: "Hi") === "Hi, Ada!");

assert(sum(1, 2, 3) === 6);

$addFive = fn($x) => $x + 5;
assert($addFive(3) === 8);

$counter = makeCounter();
assert($counter() === 1);
assert($counter() === 2);

echo "ok\n";
