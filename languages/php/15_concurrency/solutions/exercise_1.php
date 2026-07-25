<?php

function sumConcurrently(array $numbers): int
{
    $mid = intdiv(count($numbers), 2);
    $halves = [array_slice($numbers, 0, $mid), array_slice($numbers, $mid)];

    $workers = [];
    foreach ($halves as $half) {
        $pipe = [];
        socket_create_pair(AF_UNIX, SOCK_STREAM, 0, $pipe);
        $pid = pcntl_fork();
        if ($pid === 0) {
            socket_close($pipe[0]);
            socket_write($pipe[1], (string) array_sum($half));
            socket_close($pipe[1]);
            exit(0);
        }
        socket_close($pipe[1]);
        $workers[] = ["pid" => $pid, "sock" => $pipe[0]];
    }

    $total = 0;
    foreach ($workers as $w) {
        $total += (int) socket_read($w["sock"], 32);
        socket_close($w["sock"]);
        pcntl_waitpid($w["pid"], $status);
    }
    return $total;
}

$result = sumConcurrently([1, 2, 3, 4, 5, 6]);
assert($result === 21);

echo "ok\n";
