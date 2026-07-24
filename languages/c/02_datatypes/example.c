#include <assert.h>
#include <limits.h>
#include <stdint.h>
#include <stdio.h>

int main(void) {
    int n = 10;
    int32_t exact = 10;
    uint8_t byte = 255;
    assert(n == 10 && exact == 10 && byte == 255);

    assert(sizeof(int) >= 2); // standard only guarantees at least 16 bits

    unsigned int u = 0;
    u = u - 1;
    assert(u == UINT_MAX); // well-defined wraparound for unsigned

    int x = -1;
    unsigned int y = 0;
    // x gets implicitly converted to a huge unsigned value here
    assert((unsigned int)x > y);

    printf("ok\n");
    return 0;
}
