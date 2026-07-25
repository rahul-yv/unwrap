#include <assert.h>
#include <pthread.h>
#include <stdio.h>

typedef struct {
    const int *start;
    int len;
    long partial_sum;
} SumTask;

void *sum_slice(void *arg) {
    SumTask *task = (SumTask *)arg;
    long total = 0;
    for (int i = 0; i < task->len; i++) {
        total += task->start[i];
    }
    task->partial_sum = total;
    return NULL;
}

long sum_concurrently(const int *numbers, int len) {
    int mid = len / 2;

    SumTask first = {numbers, mid, 0};
    SumTask second = {numbers + mid, len - mid, 0};

    pthread_t t1, t2;
    pthread_create(&t1, NULL, sum_slice, &first);
    pthread_create(&t2, NULL, sum_slice, &second);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    return first.partial_sum + second.partial_sum;
}

int main(void) {
    int a[] = {1, 2, 3, 4};
    assert(sum_concurrently(a, 4) == 10);

    int b[] = {10, 20, 30, 40, 50};
    assert(sum_concurrently(b, 5) == 150);

    printf("ok\n");
    return 0;
}
