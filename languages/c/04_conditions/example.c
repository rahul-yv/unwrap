#include <assert.h>
#include <stdbool.h>
#include <stdio.h>

int main(void) {
    int score = 85;
    char grade;
    if (score >= 90) {
        grade = 'A';
    } else if (score >= 80) {
        grade = 'B';
    } else {
        grade = 'C';
    }
    assert(grade == 'B');

    bool passed = score >= 60;
    assert(passed == true);

    int good = 0;
    switch (grade) {
        case 'A':
        case 'B':
            good = 1;
            break;
        default:
            good = 0;
    }
    assert(good == 1);

    // fallthrough demo: no break after case 1
    int hits = 0;
    int n = 1;
    switch (n) {
        case 1:
            hits++;
            /* fallthrough */
        case 2:
            hits++;
            break;
        case 3:
            hits++;
            break;
    }
    assert(hits == 2); // fell through from case 1 into case 2

    printf("ok\n");
    return 0;
}
