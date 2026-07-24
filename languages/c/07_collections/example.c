#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

int main(void) {
    int fixed[3] = {1, 2, 3};
    assert(fixed[0] == 1 && fixed[2] == 3);

    int *dynamic = malloc(3 * sizeof(int));
    assert(dynamic != NULL);
    dynamic[0] = 1;
    dynamic[1] = 2;
    dynamic[2] = 3;
    assert(dynamic[0] == 1 && dynamic[2] == 3);

    int *grown = realloc(dynamic, 5 * sizeof(int));
    assert(grown != NULL);
    dynamic = grown;
    dynamic[3] = 4;
    dynamic[4] = 5;
    assert(dynamic[3] == 4 && dynamic[4] == 5);

    free(dynamic);
    dynamic = NULL; // avoid leaving a dangling pointer around

    printf("ok\n");
    return 0;
}
