<?php

function echoOnce(int $port, string $message): string
{
    $client = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
    socket_connect($client, "127.0.0.1", $port);
    socket_write($client, $message);
    $response = socket_read($client, 64);
    socket_close($client);
    return $response;
}

$server = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
socket_bind($server, "127.0.0.1", 0);
socket_listen($server, 1);
socket_getsockname($server, $addr, $port);

$pid = pcntl_fork();
if ($pid === 0) {
    $conn = socket_accept($server);
    $received = socket_read($conn, 64);
    socket_write($conn, $received);
    socket_close($conn);
    exit(0);
}

$result = echoOnce($port, "ping");
pcntl_waitpid($pid, $status);
socket_close($server);

assert($result === "ping");
echo "ok\n";
