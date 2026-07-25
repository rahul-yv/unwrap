<?php

function twoSum(array $nums, int $target): ?array
{
    $seen = [];
    foreach ($nums as $i => $n) {
        $complement = $target - $n;
        if (isset($seen[$complement])) {
            return [$seen[$complement], $i];
        }
        $seen[$n] = $i;
    }
    return null;
}

function isPalindrome(string $s): bool
{
    $chars = strtolower(preg_replace('/[^a-zA-Z0-9]/', '', $s));
    return $chars === strrev($chars);
}

function mergeIntervals(array $intervals): array
{
    if (empty($intervals)) {
        return [];
    }
    usort($intervals, fn($a, $b) => $a[0] <=> $b[0]);

    $merged = [$intervals[0]];
    foreach (array_slice($intervals, 1) as $interval) {
        $last = &$merged[count($merged) - 1];
        if ($interval[0] <= $last[1]) {
            $last[1] = max($last[1], $interval[1]);
        } else {
            $merged[] = $interval;
        }
        unset($last);
    }
    return $merged;
}

assert(twoSum([2, 7, 11, 15], 9) === [0, 1]);
assert(twoSum([1, 2], 100) === null);

assert(isPalindrome("A man, a plan, a canal: Panama") === true);
assert(isPalindrome("race a car") === false);

$merged = mergeIntervals([[1, 3], [2, 6], [8, 10], [15, 18]]);
assert($merged === [[1, 6], [8, 10], [15, 18]]);
assert(mergeIntervals([]) === []);

echo "ok\n";
