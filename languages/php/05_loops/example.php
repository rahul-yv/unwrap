<?php

$total = 0;
for ($i = 0; $i < 5; $i++) {
    $total += $i;
}
assert($total === 10);

$items = ["a", "b", "c"];
$indexed = [];
foreach ($items as $index => $value) {
    $indexed[] = "$index:$value";
}
assert($indexed === ["0:a", "1:b", "2:c"]);

$numbers = [1, 2, 3];
foreach ($numbers as &$n) {
    $n *= 2;
}
unset($n);
assert($numbers === [2, 4, 6]);

$count = 0;
while ($count < 3) {
    $count++;
}
assert($count === 3);

echo "ok\n";
