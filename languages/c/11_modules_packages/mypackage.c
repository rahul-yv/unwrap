#include "mypackage.h"
#include <stdio.h>

char *greet(const char *name, char *buffer, int buffer_size) {
    snprintf(buffer, (size_t)buffer_size, "Hello, %s!", name);
    return buffer;
}
