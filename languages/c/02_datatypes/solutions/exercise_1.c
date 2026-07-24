#include <assert.h>
#include <stdint.h>
#include <stdio.h>

int32_t safe_add(int32_t a, int32_t b, int *overflowed) {
    if (b > 0 && a > INT32_MAX - b) {
        *overflowed = 1;
        return 0;
    }
    if (b < 0 && a < INT32_MIN - b) {
        *overflowed = 1;
        return 0;
    }
    *overflowed = 0;
    return a + b;
}

int main(void) {
    int overflowed;

    int32_t result = safe_add(10, 20, &overflowed);
    assert(result == 30 && overflowed == 0);

    safe_add(INT32_MAX, 1, &overflowed);
    assert(overflowed == 1);

    safe_add(INT32_MIN, -1, &overflowed);
    assert(overflowed == 1);

    printf("ok\n");
    return 0;
}
