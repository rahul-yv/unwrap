import asyncio
import threading


def demo_threading():
    counter = 0
    lock = threading.Lock()

    def increment():
        nonlocal counter
        for _ in range(50_000):
            with lock:
                counter += 1

    threads = [threading.Thread(target=increment) for _ in range(4)]
    for t in threads:
        t.start()
    for t in threads:
        t.join()

    assert counter == 200_000  # exact, because the lock prevented lost updates


def demo_unlocked_race():
    counter = 0

    def increment_unsafe():
        nonlocal counter
        for _ in range(50_000):
            counter += 1  # not atomic: read-modify-write without a lock

    threads = [threading.Thread(target=increment_unsafe) for _ in range(4)]
    for t in threads:
        t.start()
    for t in threads:
        t.join()

    # without a lock, some increments are lost to the race condition;
    # this is <= rather than == because on some runs it can still hit the
    # exact value by luck, but it is not guaranteed like the locked version
    assert counter <= 200_000


async def fetch_after(seconds, value):
    await asyncio.sleep(seconds)
    return value


async def demo_asyncio():
    results = await asyncio.gather(
        fetch_after(0.01, "a"),
        fetch_after(0.01, "b"),
        fetch_after(0.01, "c"),
    )
    assert results == ["a", "b", "c"]


def demo():
    demo_threading()
    demo_unlocked_race()
    asyncio.run(demo_asyncio())


if __name__ == "__main__":
    demo()
    print("ok")
