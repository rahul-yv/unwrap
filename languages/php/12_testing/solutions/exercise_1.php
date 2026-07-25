<?php

class TestRunner
{
    private int $run = 0;
    private int $failed = 0;

    public function check(bool $condition, string $name): void
    {
        $this->run++;
        if ($condition) {
            echo "PASS: $name\n";
        } else {
            $this->failed++;
            echo "FAIL: $name\n";
        }
    }

    public function summary(): int
    {
        $passed = $this->run - $this->failed;
        echo "$passed/{$this->run} passed\n";
        return $this->failed === 0 ? 0 : 1;
    }
}

function add(int $a, int $b): int
{
    return $a + $b;
}

$t = new TestRunner();
$t->check(add(0, 0) === 0, "adds zeros");
$t->check(add(-1, 1) === 0, "adds opposite numbers");
$exitCode = $t->summary();
assert($exitCode === 0);

echo "ok\n";
