<?php

function groupAnagrams(array $words): array
{
    $groups = [];
    foreach ($words as $word) {
        $chars = str_split($word);
        sort($chars);
        $key = implode('', $chars);
        $groups[$key][] = $word;
    }
    return array_values($groups);
}

$words = ["eat", "tea", "tan", "ate", "nat", "bat"];
$groups = groupAnagrams($words);

assert(count($groups) === 3);

$sorted = array_map(function ($g) {
    sort($g);
    return $g;
}, $groups);

assert(in_array(["ate", "eat", "tea"], $sorted));
assert(in_array(["nat", "tan"], $sorted));
assert(in_array(["bat"], $sorted));

echo "ok\n";
