#include <assert.h>
#include <stdio.h>

int first_even(const int *numbers, int len) {
    for (int i = 0; i < len; i++) {
        if (numbers[i] % 2 == 0) {
            return numbers[i];
        }
    }
    return -1;
}

int main(void) {
    int a[] = {1, 3, 4, 5};
    assert(first_even(a, 4) == 4);

    int b[] = {1, 3, 5};
    assert(first_even(b, 3) == -1);

    printf("ok\n");
    return 0;
}
