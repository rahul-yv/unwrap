import threading


def count_up_concurrently(n_threads, per_thread):
    counter = 0
    lock = threading.Lock()

    def worker():
        nonlocal counter
        for _ in range(per_thread):
            with lock:
                counter += 1

    threads = [threading.Thread(target=worker) for _ in range(n_threads)]
    for t in threads:
        t.start()
    for t in threads:
        t.join()

    return counter


if __name__ == "__main__":
    assert count_up_concurrently(4, 10_000) == 40_000
    print("ok")
