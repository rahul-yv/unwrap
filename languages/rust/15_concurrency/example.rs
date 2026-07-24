use std::sync::mpsc;
use std::sync::{Arc, Mutex};
use std::thread;

fn main() {
    let counter = Arc::new(Mutex::new(0));
    let mut handles = vec![];

    for _ in 0..10 {
        let counter = Arc::clone(&counter);
        handles.push(thread::spawn(move || {
            let mut num = counter.lock().unwrap();
            *num += 1;
        }));
    }
    for handle in handles {
        handle.join().unwrap();
    }
    assert_eq!(*counter.lock().unwrap(), 10);

    let (tx, rx) = mpsc::channel();
    thread::spawn(move || {
        tx.send(42).unwrap();
    });
    assert_eq!(rx.recv().unwrap(), 42);

    // multiple messages over one channel, received in send order
    let (tx2, rx2) = mpsc::channel();
    thread::spawn(move || {
        for i in 1..=3 {
            tx2.send(i).unwrap();
        }
    });
    let received: Vec<i32> = rx2.iter().collect();
    assert_eq!(received, vec![1, 2, 3]);

    println!("ok");
}
