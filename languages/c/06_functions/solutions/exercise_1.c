#include <assert.h>
#include <stdio.h>

int apply_twice(int (*fn)(int), int x) {
    return fn(fn(x));
}

int increment(int x) {
    return x + 1;
}

int square(int x) {
    return x * x;
}

int main(void) {
    assert(apply_twice(increment, 5) == 7);
    assert(apply_twice(square, 2) == 16); // square(square(2)) = square(4) = 16

    printf("ok\n");
    return 0;
}
