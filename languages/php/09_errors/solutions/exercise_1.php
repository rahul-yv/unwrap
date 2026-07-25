<?php

function safeParseInt(string $s): int|false
{
    if (!is_numeric($s)) {
        return false;
    }
    return (int) $s;
}

assert(safeParseInt("42") === 42);
assert(safeParseInt("not a number") === false);

echo "ok\n";
