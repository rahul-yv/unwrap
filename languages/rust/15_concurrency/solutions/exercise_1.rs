use std::sync::mpsc;
use std::thread;

fn sum_concurrently(numbers: Vec<i32>) -> i32 {
    let mid = numbers.len() / 2;
    let mut first_half = numbers;
    let second_half = first_half.split_off(mid);

    let (tx, rx) = mpsc::channel();

    let tx1 = tx.clone();
    thread::spawn(move || {
        let total: i32 = first_half.iter().sum();
        tx1.send(total).unwrap();
    });

    thread::spawn(move || {
        let total: i32 = second_half.iter().sum();
        tx.send(total).unwrap();
    });

    rx.recv().unwrap() + rx.recv().unwrap()
}

fn main() {
    assert_eq!(sum_concurrently(vec![1, 2, 3, 4]), 10);
    assert_eq!(sum_concurrently(vec![]), 0);
    println!("ok");
}
