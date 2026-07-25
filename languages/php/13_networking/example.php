<?php

$server = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
assert($server !== false);
socket_bind($server, "127.0.0.1", 0);
socket_listen($server, 1);
socket_getsockname($server, $addr, $port);

$client = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
socket_connect($client, "127.0.0.1", $port);

$conn = socket_accept($server);
assert($conn !== false);

socket_write($client, "ping");
$received = socket_read($conn, 16);
assert($received === "ping");

socket_close($client);
socket_close($conn);
socket_close($server);

echo "ok\n";
