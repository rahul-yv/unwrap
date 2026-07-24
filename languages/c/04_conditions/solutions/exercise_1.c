#include <assert.h>
#include <stdio.h>

char grade(int score) {
    if (score >= 90) {
        return 'A';
    } else if (score >= 80) {
        return 'B';
    } else if (score >= 70) {
        return 'C';
    } else {
        return 'F';
    }
}

int main(void) {
    assert(grade(95) == 'A');
    assert(grade(72) == 'C');
    assert(grade(40) == 'F');

    printf("ok\n");
    return 0;
}
