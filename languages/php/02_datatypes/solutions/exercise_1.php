<?php

function safeLength(?string $s): int
{
    return strlen($s ?? "");
}

assert(safeLength(null) === 0);
assert(safeLength("hello") === 5);

echo "ok\n";
