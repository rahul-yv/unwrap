#include <assert.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>

int divide(int a, int b, int *result) {
    if (b == 0) {
        return -1;
    }
    *result = a / b;
    return 0;
}

int main(void) {
    FILE *f = fopen("definitely-missing-unwrap.txt", "r");
    assert(f == NULL);
    assert(strlen(strerror(errno)) > 0); // errno was set, and decodes to a message

    int result;
    int status = divide(10, 2, &result);
    assert(status == 0 && result == 5);

    int unused;
    int failed_status = divide(10, 0, &unused);
    assert(failed_status == -1);

    printf("ok\n");
    return 0;
}
