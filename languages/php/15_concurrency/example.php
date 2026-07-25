<?php

function sumHalf(array $numbers): int
{
    return array_sum($numbers);
}

$pipe = [];
socket_create_pair(AF_UNIX, SOCK_STREAM, 0, $pipe);
$pid = pcntl_fork();
if ($pid === 0) {
    socket_close($pipe[0]);
    $sum = sumHalf([1, 2, 3]);
    socket_write($pipe[1], (string) $sum);
    socket_close($pipe[1]);
    exit(0);
}
socket_close($pipe[1]);
$partial = (int) socket_read($pipe[0], 32);
socket_close($pipe[0]);
pcntl_waitpid($pid, $status);

assert($partial === 6);

echo "ok\n";
