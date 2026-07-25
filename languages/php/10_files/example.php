<?php

$path = tempnam(sys_get_temp_dir(), "unwrap");

file_put_contents($path, "line one\nline two\n");

$content = file_get_contents($path);
assert($content === "line one\nline two\n");

$lines = file($path, FILE_IGNORE_NEW_LINES);
assert($lines === ["line one", "line two"]);

file_put_contents($path, "line three\n", FILE_APPEND);
assert(file($path, FILE_IGNORE_NEW_LINES) === ["line one", "line two", "line three"]);

$lineCount = 0;
$handle = fopen($path, "r");
while (fgets($handle) !== false) {
    $lineCount++;
}
fclose($handle);
assert($lineCount === 3);

unlink($path);
assert(!file_exists($path));

echo "ok\n";
