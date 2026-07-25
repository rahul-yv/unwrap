#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

#define MAX_WORD_LEN 64

typedef struct {
    char word[MAX_WORD_LEN];
    int count;
} WordCount;

// Count words in `text` into `entries` (capacity `max_entries`).
// Returns the number of distinct words recorded.
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

int find_word(const WordCount *entries, int count, const char *word) {
    for (int i = 0; i < count; i++) {
        if (strcmp(entries[i].word, word) == 0) {
            return entries[i].count;
        }
    }
    return 0;
}

int main(void) {
    WordCount entries[64];
    int count = count_words("The cat sat. The cat ran!", entries, 64);

    assert(count == 4); // the, cat, sat, ran
    assert(find_word(entries, count, "the") == 2);
    assert(find_word(entries, count, "cat") == 2);
    assert(find_word(entries, count, "sat") == 1);
    assert(find_word(entries, count, "missing") == 0);

    printf("ok\n");
    return 0;
}
