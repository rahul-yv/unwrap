use std::io::{Read, Write};
use std::net::{TcpListener, TcpStream};
use std::thread;

fn send_and_receive(addr: &str, request: &[u8]) -> std::io::Result<Vec<u8>> {
    let mut stream = TcpStream::connect(addr)?;
    stream.write_all(request)?;

    let mut buffer = [0; 1024];
    let n = stream.read(&mut buffer)?;
    Ok(buffer[..n].to_vec())
}

fn main() {
    let listener = TcpListener::bind("127.0.0.1:0").expect("bind should succeed");
    let port = listener.local_addr().unwrap().port();

    let handle = thread::spawn(move || {
        if let Ok((mut stream, _)) = listener.accept() {
            let mut buffer = [0; 1024];
            let _ = stream.read(&mut buffer);
            let _ = stream.write_all(b"pong");
        }
    });

    let addr = format!("127.0.0.1:{}", port);
    let response = send_and_receive(&addr, b"ping").expect("send_and_receive should succeed");
    assert_eq!(response, b"pong");

    handle.join().unwrap();
    println!("ok");
}
