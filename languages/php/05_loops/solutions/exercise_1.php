<?php

function sumEvens(int $n): int
{
    $total = 0;
    for ($i = 0; $i <= $n; $i += 2) {
        $total += $i;
    }
    return $total;
}

assert(sumEvens(10) === 30);
assert(sumEvens(0) === 0);

echo "ok\n";
