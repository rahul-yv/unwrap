use std::collections::HashMap;

fn main() {
    let nums = vec![1, 2, 3, 4, 5];
    let squares: Vec<i32> = nums.iter().map(|n| n * n).collect();
    assert_eq!(squares, vec![1, 4, 9, 16, 25]);

    let evens: Vec<&i32> = nums.iter().filter(|&&n| n % 2 == 0).collect();
    assert_eq!(evens, vec![&2, &4]);

    let mut scores: HashMap<String, i32> = HashMap::new();
    scores.insert(String::from("a"), 1);
    assert_eq!(scores.get("a"), Some(&1));
    assert_eq!(scores.get("z"), None);
    assert_eq!(*scores.get("z").unwrap_or(&0), 0);

    // iter() borrows: nums is still usable afterward
    let sum: i32 = nums.iter().sum();
    assert_eq!(sum, 15);
    assert_eq!(nums.len(), 5);

    // into_iter() consumes: the original is no longer usable
    let doubled: Vec<i32> = nums.into_iter().map(|n| n * 2).collect();
    assert_eq!(doubled, vec![2, 4, 6, 8, 10]);
    // nums.len() here would be a compile error: value used after move

    println!("ok");
}
