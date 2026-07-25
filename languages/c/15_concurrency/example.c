#include <assert.h>
#include <pthread.h>
#include <stdio.h>

int counter = 0;
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void *increment(void *arg) {
    (void)arg;
    for (int i = 0; i < 100000; i++) {
        pthread_mutex_lock(&lock);
        counter++;
        pthread_mutex_unlock(&lock);
    }
    return NULL;
}

int main(void) {
    pthread_t threads[4];
    for (int i = 0; i < 4; i++) {
        assert(pthread_create(&threads[i], NULL, increment, NULL) == 0);
    }
    for (int i = 0; i < 4; i++) {
        assert(pthread_join(threads[i], NULL) == 0);
    }

    assert(counter == 400000); // exact: the mutex prevented every lost update

    printf("ok\n");
    return 0;
}
