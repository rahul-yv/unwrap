#include <assert.h>
#include <stdio.h>

int safe_divide(int a, int b, int *result) {
    if (b == 0) {
        return -1;
    }
    *result = a / b;
    return 0;
}

int main(void) {
    int result = 0;
    assert(safe_divide(10, 2, &result) == 0);
    assert(result == 5);

    assert(safe_divide(10, 0, &result) == -1);
    assert(result == 5); // untouched by the failed call

    printf("ok\n");
    return 0;
}
