<?php

function countWords(string $text): array
{
    preg_match_all("/[a-z']+/", strtolower($text), $matches);
    $counts = [];
    foreach ($matches[0] as $word) {
        $counts[$word] = ($counts[$word] ?? 0) + 1;
    }
    return $counts;
}

function topWords(string $path, int $n): array
{
    $content = file_get_contents($path);
    if ($content === false) {
        throw new RuntimeException("could not read file: $path");
    }
    $counts = countWords($content);
    arsort($counts);
    return array_slice($counts, 0, $n, true);
}

$counts = countWords("The cat sat. The cat ran!");
assert($counts["the"] === 2);
assert($counts["cat"] === 2);

$path = tempnam(sys_get_temp_dir(), "unwrap");
file_put_contents($path, "dog dog cat bird dog cat");

$top = topWords($path, 2);
assert($top === ["dog" => 3, "cat" => 2]);

$threw = false;
try {
    topWords("/tmp/unwrap-php-missing-" . uniqid() . ".txt", 2);
} catch (RuntimeException $e) {
    $threw = true;
}
assert($threw);

unlink($path);

echo "ok\n";
