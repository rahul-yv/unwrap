<?php

enum Shape: string
{
    case Circle = "circle";
    case Square = "square";
}

function describe(Shape $shape): string
{
    return match ($shape) {
        Shape::Circle => "a round shape",
        Shape::Square => "a four-sided shape",
    };
}

assert(describe(Shape::Circle) === "a round shape");
assert(describe(Shape::Square) === "a four-sided shape");

echo "ok\n";
