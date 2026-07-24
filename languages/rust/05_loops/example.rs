fn main() {
    let mut collected = Vec::new();
    for i in 0..3 {
        collected.push(i);
    }
    assert_eq!(collected, vec![0, 1, 2]);

    let mut items = Vec::new();
    for item in ["a", "b", "c"] {
        items.push(item);
    }
    assert_eq!(items, vec!["a", "b", "c"]);

    let mut n = 0;
    while n < 3 {
        n += 1;
    }
    assert_eq!(n, 3);

    let mut counter = 0;
    let result = loop {
        counter += 1;
        if counter == 5 {
            break counter * 2;
        }
    };
    assert_eq!(result, 10);

    // borrowing with &vec leaves the original usable afterward
    let numbers = vec![1, 2, 3];
    let mut sum = 0;
    for n in &numbers {
        sum += n;
    }
    assert_eq!(sum, 6);
    assert_eq!(numbers.len(), 3); // numbers is still usable, since it was borrowed

    println!("ok");
}
