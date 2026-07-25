<?php

function wordLengths(array $words): array
{
    return array_combine($words, array_map('strlen', $words));
}

$result = wordLengths(["a", "bb", "ccc"]);
assert($result === ["a" => 1, "bb" => 2, "ccc" => 3]);

echo "ok\n";
