<?php

function greet(?string $name): string
{
    return "Hello, " . ($name ?? "stranger");
}

$i = 42;
$f = 3.14;
$s = "hello";
$b = true;
$n = null;
assert($i === 42 && $s === "hello" && $b === true && $n === null);
assert($f > 3.1 && $f < 3.2);

$loose = ("5" == 5);
$strict = ("5" === 5);
assert($loose === true);
assert($strict === false);

$name = null;
$length = $name ?? "default";
assert($length === "default");

assert(greet(null) === "Hello, stranger");
assert(greet("Ada") === "Hello, Ada");

$ratio = 3 / 2;
$intdiv = intdiv(3, 2);
assert($ratio === 1.5);
assert($intdiv === 1);

echo "ok\n";
