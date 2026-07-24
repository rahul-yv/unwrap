#include <assert.h>
#include <stdio.h>

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int main(void) {
    int x = 1, y = 2;
    swap(&x, &y);
    assert(x == 2 && y == 1);

    printf("ok\n");
    return 0;
}
