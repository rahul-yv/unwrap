<?php

function grade(int $score): string
{
    return match (true) {
        $score >= 90 => "A",
        $score >= 80 => "B",
        $score >= 70 => "C",
        default => "F",
    };
}

assert(grade(95) === "A");
assert(grade(85) === "B");
assert(grade(75) === "C");
assert(grade(50) === "F");

echo "ok\n";
