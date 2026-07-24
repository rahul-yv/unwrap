#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

int *make_range(int start, int end, int *out_len) {
    int len = end - start + 1;
    if (len <= 0) {
        *out_len = 0;
        return NULL;
    }

    int *result = malloc((size_t)len * sizeof(int));
    if (result == NULL) {
        *out_len = 0;
        return NULL;
    }

    for (int i = 0; i < len; i++) {
        result[i] = start + i;
    }
    *out_len = len;
    return result;
}

int main(void) {
    int len;
    int *range = make_range(1, 5, &len);

    assert(len == 5);
    assert(range[0] == 1 && range[4] == 5);

    free(range);

    printf("ok\n");
    return 0;
}
