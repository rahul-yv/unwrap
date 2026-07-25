<?php

require __DIR__ . "/mypackage/Helpers.php";

use function MyPackage\greet;

assert(greet("Ada") === "Hello, Ada!");

echo "ok\n";
