<?php

function makeCounter(): callable
{
    $count = 0;
    return function () use (&$count) {
        return ++$count;
    };
}

$counter = makeCounter();
assert($counter() === 1);
assert($counter() === 2);
assert($counter() === 3);

$other = makeCounter();
assert($other() === 1);

echo "ok\n";
