#include <assert.h>
#include <stdio.h>

int main(void) {
    int age = 25;
    double pi = 3.14159;
    char grade = 'A';

    age = age + 1;
    assert(age == 26);
    assert(grade == 'A');
    assert(pi > 3.14 && pi < 3.15);

    const int max_retries = 3;
    assert(max_retries == 3);

    // integer literals default to `int`; without the L suffix this
    // multiplication overflows int before being widened to long
    long correct = 100000L * 100000L;
    assert(correct == 10000000000L);

    // const int *p: the int p points to can't change through p
    int value = 10;
    const int *p = &value;
    value = 20; // fine: value itself isn't const
    assert(*p == 20);

    // int * const q: q itself can't be reassigned, but *q can be modified
    int other = 1;
    int *const q = &other;
    *q = 99;
    assert(other == 99);

    printf("ok\n");
    return 0;
}
