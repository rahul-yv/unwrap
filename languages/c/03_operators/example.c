#include <assert.h>
#include <stdio.h>

int main(void) {
    int a = 6, b = 3; // 0b0110, 0b0011

    assert((a & b) == 2);
    assert((a | b) == 7);
    assert((a ^ b) == 5);
    assert((~a & 0xFF) == 0xF9);
    assert((a << 1) == 12);
    assert((a >> 1) == 3);

    int max = (a > b) ? a : b;
    assert(max == a);

    // & vs && do very different things
    int bitwise = a & b; // 2
    int logical = a && b; // 1 (both nonzero, so true)
    assert(bitwise == 2 && logical == 1);

    // = inside a condition is a classic bug — this is deliberately
    // written as a comparison, not an assignment
    int x = 5;
    if (x == 5) {
        x = 10;
    }
    assert(x == 10);

    printf("ok\n");
    return 0;
}
