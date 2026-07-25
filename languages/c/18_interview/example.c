#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

int two_sum(const int *nums, int len, int target, int *i, int *j) {
    for (int a = 0; a < len; a++) {
        for (int b = a + 1; b < len; b++) {
            if (nums[a] + nums[b] == target) {
                *i = a;
                *j = b;
                return 1;
            }
        }
    }
    return 0;
}

int is_palindrome(const char *s) {
    int left = 0, right = (int)strlen(s) - 1;
    while (left < right) {
        while (left < right && !isalnum((unsigned char)s[left])) {
            left++;
        }
        while (left < right && !isalnum((unsigned char)s[right])) {
            right--;
        }
        if (tolower((unsigned char)s[left]) != tolower((unsigned char)s[right])) {
            return 0;
        }
        left++;
        right--;
    }
    return 1;
}

// merge overlapping [start, end] intervals in place; returns the merged count.
// `intervals` must be sorted by start (this simple version assumes that).
int merge_intervals(int intervals[][2], int count) {
    if (count == 0) {
        return 0;
    }
    int merged = 0;
    for (int i = 1; i < count; i++) {
        if (intervals[i][0] <= intervals[merged][1]) {
            if (intervals[i][1] > intervals[merged][1]) {
                intervals[merged][1] = intervals[i][1];
            }
        } else {
            merged++;
            intervals[merged][0] = intervals[i][0];
            intervals[merged][1] = intervals[i][1];
        }
    }
    return merged + 1;
}

int main(void) {
    int nums[] = {2, 7, 11, 15};
    int i, j;
    assert(two_sum(nums, 4, 9, &i, &j) == 1 && i == 0 && j == 1);
    assert(two_sum(nums, 4, 100, &i, &j) == 0);

    assert(is_palindrome("A man, a plan, a canal: Panama") == 1);
    assert(is_palindrome("race a car") == 0);

    int intervals[][2] = {{1, 3}, {2, 6}, {8, 10}, {15, 18}};
    int merged = merge_intervals(intervals, 4);
    assert(merged == 3);
    assert(intervals[0][0] == 1 && intervals[0][1] == 6);

    printf("ok\n");
    return 0;
}
