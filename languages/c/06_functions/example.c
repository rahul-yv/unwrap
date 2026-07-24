#include <assert.h>
#include <stdio.h>

void increment(int x) {
    x = x + 1;
}

void increment_via_pointer(int *x) {
    *x = *x + 1;
}

int add(int a, int b) {
    return a + b;
}

int multiply(int a, int b) {
    return a * b;
}

int apply(int (*op)(int, int), int a, int b) {
    return op(a, b);
}

static int internal_helper(int x) {
    return x * 2;
}

int main(void) {
    int n = 5;
    increment(n);
    assert(n == 5); // unchanged: pass by value

    increment_via_pointer(&n);
    assert(n == 6); // changed: through the pointer

    assert(apply(add, 2, 3) == 5);
    assert(apply(multiply, 2, 3) == 6);

    assert(internal_helper(4) == 8);

    printf("ok\n");
    return 0;
}
