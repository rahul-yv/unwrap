use std::collections::HashMap;

fn two_sum(nums: &[i32], target: i32) -> Option<(usize, usize)> {
    let mut seen: HashMap<i32, usize> = HashMap::new();
    for (i, &n) in nums.iter().enumerate() {
        if let Some(&j) = seen.get(&(target - n)) {
            return Some((j, i));
        }
        seen.insert(n, i);
    }
    None
}

fn is_palindrome(s: &str) -> bool {
    let chars: Vec<char> = s.chars().filter(|c| c.is_alphanumeric()).collect();
    let lowered: Vec<char> = chars.iter().map(|c| c.to_ascii_lowercase()).collect();
    lowered.iter().eq(lowered.iter().rev())
}

fn merge_intervals(intervals: &[[i32; 2]]) -> Vec<[i32; 2]> {
    if intervals.is_empty() {
        return vec![];
    }
    let mut sorted = intervals.to_vec();
    sorted.sort_by_key(|iv| iv[0]);

    let mut merged = vec![sorted[0]];
    for interval in &sorted[1..] {
        let last = merged.last_mut().unwrap();
        if interval[0] <= last[1] {
            last[1] = last[1].max(interval[1]);
        } else {
            merged.push(*interval);
        }
    }
    merged
}

fn main() {
    assert_eq!(two_sum(&[2, 7, 11, 15], 9), Some((0, 1)));
    assert_eq!(two_sum(&[1, 2], 100), None);

    assert!(is_palindrome("A man, a plan, a canal: Panama"));
    assert!(!is_palindrome("race a car"));

    let merged = merge_intervals(&[[1, 3], [2, 6], [8, 10], [15, 18]]);
    assert_eq!(merged, vec![[1, 6], [8, 10], [15, 18]]);
    assert_eq!(merge_intervals(&[]), Vec::<[i32; 2]>::new());

    println!("ok");
}
