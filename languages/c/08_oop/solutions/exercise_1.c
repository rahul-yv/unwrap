#include <assert.h>
#include <stdio.h>

typedef struct {
    double width;
    double height;
} Rectangle;

double rectangle_area(const Rectangle *r) {
    return r->width * r->height;
}

int rectangle_equals(const Rectangle *a, const Rectangle *b) {
    return a->width == b->width && a->height == b->height;
}

int main(void) {
    Rectangle r1 = {3, 4};
    Rectangle r2 = {3, 4};
    Rectangle r3 = {4, 3};

    assert(rectangle_area(&r1) == 12);
    assert(rectangle_equals(&r1, &r2) == 1);
    assert(rectangle_equals(&r1, &r3) == 0);

    printf("ok\n");
    return 0;
}
