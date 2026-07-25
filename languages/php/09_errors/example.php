<?php

function divide(int $a, int $b): int
{
    if ($b === 0) {
        throw new DivisionByZeroError("division by zero");
    }
    return intdiv($a, $b);
}

class InvalidAmountException extends Exception {}

function withdraw(float $amount): void
{
    if ($amount < 0) {
        throw new InvalidAmountException("amount cannot be negative");
    }
}

$finallyRan = false;
try {
    $result = divide(10, 0);
} catch (DivisionByZeroError $e) {
    $result = -1;
} finally {
    $finallyRan = true;
}
assert($result === -1);
assert($finallyRan === true);

assert(divide(10, 2) === 5);

$caught = false;
try {
    withdraw(-5);
} catch (InvalidAmountException | TypeError $e) {
    $caught = true;
}
assert($caught === true);

echo "ok\n";
