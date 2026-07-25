#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

#define MAX_WORD_LEN 64

typedef struct {
    char word[MAX_WORD_LEN];
    int count;
} WordCount;

int count_words(const char *text, WordCount *entries, int max_entries) {
    int num_entries = 0;
    char buffer[MAX_WORD_LEN];
    int buf_len = 0;

    for (const char *p = text;; p++) {
        char c = *p;
        if (isalpha((unsigned char)c)) {
            if (buf_len < MAX_WORD_LEN - 1) {
                buffer[buf_len++] = (char)tolower((unsigned char)c);
            }
        } else if (buf_len > 0) {
            buffer[buf_len] = '\0';
            int found = -1;
            for (int i = 0; i < num_entries; i++) {
                if (strcmp(entries[i].word, buffer) == 0) {
                    found = i;
                    break;
                }
            }
            if (found >= 0) {
                entries[found].count++;
            } else if (num_entries < max_entries) {
                strcpy(entries[num_entries].word, buffer);
                entries[num_entries].count = 1;
                num_entries++;
            }
            buf_len = 0;
        }
        if (c == '\0') {
            break;
        }
    }
    return num_entries;
}

int most_frequent(const WordCount *entries, int count) {
    if (count == 0) {
        return -1;
    }
    int best = 0;
    for (int i = 1; i < count; i++) {
        if (entries[i].count > entries[best].count) {
            best = i;
        }
    }
    return best;
}

int main(void) {
    WordCount entries[64];
    int count = count_words("dog dog cat bird dog cat", entries, 64);

    int top = most_frequent(entries, count);
    assert(top >= 0);
    assert(strcmp(entries[top].word, "dog") == 0);
    assert(entries[top].count == 3);

    assert(most_frequent(entries, 0) == -1);

    printf("ok\n");
    return 0;
}
