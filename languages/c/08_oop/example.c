#include <assert.h>
#include <stdio.h>

typedef struct {
    double width;
    double height;
} Rectangle;

double rectangle_area(const Rectangle *r) {
    return r->width * r->height;
}

typedef struct Shape {
    double (*area)(const struct Shape *self);
    double width, height;
} Shape;

double shape_area(const Shape *self) {
    return self->width * self->height;
}

int main(void) {
    Rectangle r = {.width = 3, .height = 4};
    assert(rectangle_area(&r) == 12);

    Shape rect_shape = {.area = shape_area, .width = 3, .height = 4};
    assert(rect_shape.area(&rect_shape) == 12);

    Shape other_shape = {.area = shape_area, .width = 5, .height = 2};
    assert(other_shape.area(&other_shape) == 10);

    // both "instances" go through the same function pointer field,
    // but each carries its own data — polymorphism via a manual vtable
    Shape *shapes[] = {&rect_shape, &other_shape};
    double total = 0;
    for (int i = 0; i < 2; i++) {
        total += shapes[i]->area(shapes[i]);
    }
    assert(total == 22);

    printf("ok\n");
    return 0;
}
