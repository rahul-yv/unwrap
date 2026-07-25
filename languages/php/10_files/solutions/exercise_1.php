<?php

function countLines(string $path): int
{
    $count = 0;
    $handle = fopen($path, "r");
    while (fgets($handle) !== false) {
        $count++;
    }
    fclose($handle);
    return $count;
}

$path = tempnam(sys_get_temp_dir(), "unwrap");
file_put_contents($path, "a\nb\nc\n");

assert(countLines($path) === 3);

unlink($path);
echo "ok\n";
