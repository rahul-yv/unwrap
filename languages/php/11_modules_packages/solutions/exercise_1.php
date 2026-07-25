<?php

require __DIR__ . "/../mypackage/Helpers.php";

use function MyPackage\greet;

function exampleUsage(): string
{
    return greet("World");
}

assert(exampleUsage() === "Hello, World!");

echo "ok\n";
