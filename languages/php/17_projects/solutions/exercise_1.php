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

function topWordsExcluding(string $path, int $n, array $stopwords): array
{
    $content = file_get_contents($path);
    if ($content === false) {
        throw new RuntimeException("could not read file: $path");
    }
    $counts = countWords($content);
    $counts = array_diff_key($counts, array_flip($stopwords));
    arsort($counts);
    return array_slice($counts, 0, $n, true);
}

$path = tempnam(sys_get_temp_dir(), "unwrap");
file_put_contents($path, "the dog and the cat and the bird");

$top = topWordsExcluding($path, 2, ["the", "and"]);

assert(count($top) === 2);
assert(array_sum($top) === 2);

unlink($path);

echo "ok\n";
