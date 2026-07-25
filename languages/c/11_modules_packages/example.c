#include "mypackage.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>

int main(void) {
    char buffer[64];
    greet("Ada", buffer, sizeof(buffer));
    assert(strcmp(buffer, "Hello, Ada!") == 0);

    printf("ok\n");
    return 0;
}
