#include <assert.h>
#include <stdio.h>

int count_lines(const char *path) {
    FILE *f = fopen(path, "r");
    if (f == NULL) {
        return -1;
    }

    int lines = 0;
    char buffer[256];
    while (fgets(buffer, sizeof(buffer), f) != NULL) {
        lines++;
    }

    fclose(f);
    return lines;
}

int main(void) {
    char path[] = "/tmp/unwrap-c-count.txt";
    FILE *f = fopen(path, "w");
    fprintf(f, "a\nb\nc\n");
    fclose(f);

    assert(count_lines(path) == 3);
    assert(count_lines("/tmp/unwrap-c-missing.txt") == -1);

    remove(path);
    printf("ok\n");
    return 0;
}
