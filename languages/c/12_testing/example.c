#include <stdio.h>

static int tests_run = 0;
static int tests_failed = 0;

#define TEST_EQ(actual, expected, name)                \
    do {                                                \
        tests_run++;                                    \
        if ((actual) != (expected)) {                    \
            tests_failed++;                               \
            printf("FAIL: %s\n", name);                    \
        } else {                                            \
            printf("PASS: %s\n", name);                      \
        }                                                      \
    } while (0)

int add(int a, int b) {
    return a + b;
}

int main(void) {
    TEST_EQ(add(2, 3), 5, "adds positive numbers");
    TEST_EQ(add(-2, -3), -5, "adds negative numbers");
    TEST_EQ(add(0, 0), 0, "adds zero");

    printf("%d/%d tests passed\n", tests_run - tests_failed, tests_run);
    if (tests_failed == 0) {
        printf("ok\n");
    }
    return tests_failed == 0 ? 0 : 1;
}
