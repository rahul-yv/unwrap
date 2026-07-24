fn first_even(numbers: &[i32]) -> Option<i32> {
    for &n in numbers {
        if n % 2 == 0 {
            return Some(n);
        }
    }
    None
}

fn main() {
    assert_eq!(first_even(&[1, 3, 4, 5]), Some(4));
    assert_eq!(first_even(&[1, 3, 5]), None);
    println!("ok");
}
