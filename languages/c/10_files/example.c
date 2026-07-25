#include <assert.h>
#include <stdio.h>
#include <string.h>

int main(void) {
    char path[] = "/tmp/unwrap-c-notes.txt";

    FILE *out = fopen(path, "w");
    assert(out != NULL);
    fprintf(out, "line one\n");
    fprintf(out, "line two\n");
    fclose(out);

    FILE *in = fopen(path, "r");
    assert(in != NULL);

    char buffer[256];
    int lines = 0;
    char first_line[256] = "";
    while (fgets(buffer, sizeof(buffer), in) != NULL) {
        if (lines == 0) {
            strncpy(first_line, buffer, sizeof(first_line) - 1);
        }
        lines++;
    }
    fclose(in);

    assert(lines == 2);
    assert(strcmp(first_line, "line one\n") == 0); // fgets keeps the newline

    // strip the trailing newline manually
    first_line[strcspn(first_line, "\n")] = '\0';
    assert(strcmp(first_line, "line one") == 0);

    FILE *missing = fopen("/tmp/unwrap-c-definitely-missing.txt", "r");
    assert(missing == NULL);

    remove(path);

    printf("ok\n");
    return 0;
}
