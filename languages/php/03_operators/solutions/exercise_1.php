<?php

function clamp(int $value, int $min, int $max): int
{
    return max($min, min($value, $max));
}

assert(clamp(5, 0, 10) === 5);
assert(clamp(-5, 0, 10) === 0);
assert(clamp(15, 0, 10) === 10);

echo "ok\n";
