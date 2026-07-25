#include "../mypackage.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>

char *example_usage(char *buffer, int buffer_size) {
    return greet("World", buffer, buffer_size);
}

int main(void) {
    char buffer[64];
    example_usage(buffer, sizeof(buffer));
    assert(strcmp(buffer, "Hello, World!") == 0);

    printf("ok\n");
    return 0;
}
