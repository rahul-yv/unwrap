#include <assert.h>
#include <stdio.h>

int is_power_of_two(unsigned int n) {
    if (n == 0) {
        return 0;
    }
    return (n & (n - 1)) == 0;
}

int main(void) {
    assert(is_power_of_two(8) == 1);
    assert(is_power_of_two(10) == 0);
    assert(is_power_of_two(0) == 0);
    assert(is_power_of_two(1) == 1);

    printf("ok\n");
    return 0;
}
