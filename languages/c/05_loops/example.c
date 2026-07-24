#include <assert.h>
#include <stdio.h>

int main(void) {
    int seen[3];
    for (int i = 0; i < 3; i++) {
        seen[i] = i;
    }
    assert(seen[0] == 0 && seen[1] == 1 && seen[2] == 2);

    int arr[] = {10, 20, 30};
    int len = sizeof(arr) / sizeof(arr[0]);
    assert(len == 3);

    int sum = 0;
    for (int i = 0; i < len; i++) {
        sum += arr[i];
    }
    assert(sum == 60);

    int n = 0;
    while (n < 3) {
        n++;
    }
    assert(n == 3);

    int count = 0;
    do {
        count++;
    } while (count < 3);
    assert(count == 3);

    // do-while always runs the body at least once, even if the condition
    // starts false
    int ran_once = 0;
    do {
        ran_once = 1;
    } while (0);
    assert(ran_once == 1);

    printf("ok\n");
    return 0;
}
