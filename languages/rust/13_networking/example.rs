use std::io::{Read, Write};
use std::net::{TcpListener, TcpStream};
use std::thread;
use std::time::Duration;

fn run_server(listener: TcpListener) {
    if let Ok((mut stream, _)) = listener.accept() {
        let mut buffer = [0; 1024];
        let n = stream.read(&mut buffer).unwrap_or(0);
        let request = String::from_utf8_lossy(&buffer[..n]);

        let response = if request.starts_with("GET / ") {
            "HTTP/1.1 200 OK\r\nContent-Length: 2\r\n\r\nok"
        } else {
            "HTTP/1.1 404 Not Found\r\nContent-Length: 0\r\n\r\n"
        };
        let _ = stream.write_all(response.as_bytes());
    }
}

fn main() {
    let listener = TcpListener::bind("127.0.0.1:0").expect("bind should succeed");
    let port = listener.local_addr().unwrap().port();

    let handle = thread::spawn(move || run_server(listener));

    let mut client = TcpStream::connect(("127.0.0.1", port)).expect("connect should succeed");
    client
        .set_read_timeout(Some(Duration::from_secs(5)))
        .unwrap();
    client
        .write_all(b"GET / HTTP/1.1\r\nHost: localhost\r\n\r\n")
        .expect("write should succeed");

    let mut response = [0; 1024];
    let n = client.read(&mut response).expect("read should succeed");
    let response_text = String::from_utf8_lossy(&response[..n]);

    assert!(response_text.starts_with("HTTP/1.1 200 OK"));
    assert!(response_text.ends_with("ok"));

    handle.join().unwrap();

    println!("ok");
}
