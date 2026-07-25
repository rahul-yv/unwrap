<?php

function swap($a, $b): array
{
    return [$b, $a];
}

[$x, $y] = swap(1, 2);
assert($x === 2 && $y === 1);

echo "ok\n";
