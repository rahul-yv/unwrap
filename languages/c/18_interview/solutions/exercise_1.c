#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

struct Node {
    int value;
    struct Node *next;
};

struct Node *reverse_list(struct Node *head) {
    struct Node *previous = NULL;
    struct Node *current = head;
    while (current != NULL) {
        struct Node *next = current->next;
        current->next = previous;
        previous = current;
        current = next;
    }
    return previous;
}

// helpers for the test
struct Node *make_node(int value, struct Node *next) {
    struct Node *n = malloc(sizeof(struct Node));
    n->value = value;
    n->next = next;
    return n;
}

void free_list(struct Node *head) {
    while (head != NULL) {
        struct Node *next = head->next;
        free(head);
        head = next;
    }
}

int main(void) {
    // build 1 -> 2 -> 3
    struct Node *head = make_node(1, make_node(2, make_node(3, NULL)));

    head = reverse_list(head);

    // expect 3 -> 2 -> 1
    assert(head->value == 3);
    assert(head->next->value == 2);
    assert(head->next->next->value == 1);
    assert(head->next->next->next == NULL);

    free_list(head);

    // reversing an empty list returns NULL
    assert(reverse_list(NULL) == NULL);

    printf("ok\n");
    return 0;
}
