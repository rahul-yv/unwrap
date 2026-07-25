#if canImport(Glibc)
import Glibc
let streamSocketType = Int32(SOCK_STREAM.rawValue)
#else
import Darwin
let streamSocketType = SOCK_STREAM
#endif
import Foundation

func echoOnce(port: UInt16, message: String) -> String {
    let clientFd = socket(AF_INET, streamSocketType, 0)
    var target = sockaddr_in()
    target.sin_family = sa_family_t(AF_INET)
    target.sin_addr.s_addr = inet_addr("127.0.0.1")
    target.sin_port = port

    _ = withUnsafePointer(to: &target) { ptr -> Int32 in
        ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockaddrPtr in
            connect(clientFd, sockaddrPtr, socklen_t(MemoryLayout<sockaddr_in>.size))
        }
    }

    _ = message.withCString { send(clientFd, $0, strlen($0), 0) }

    var buffer = [UInt8](repeating: 0, count: 64)
    let received = recv(clientFd, &buffer, 64, 0)
    close(clientFd)
    return String(decoding: buffer[0..<Int(received)], as: UTF8.self)
}

let serverFd = socket(AF_INET, streamSocketType, 0)
var addr = sockaddr_in()
addr.sin_family = sa_family_t(AF_INET)
addr.sin_addr.s_addr = inet_addr("127.0.0.1")
addr.sin_port = 0

_ = withUnsafePointer(to: &addr) { ptr -> Int32 in
    ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockaddrPtr in
        bind(serverFd, sockaddrPtr, socklen_t(MemoryLayout<sockaddr_in>.size))
    }
}
listen(serverFd, 1)

var boundAddr = sockaddr_in()
var boundLen = socklen_t(MemoryLayout<sockaddr_in>.size)
_ = withUnsafeMutablePointer(to: &boundAddr) { ptr -> Int32 in
    ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockaddrPtr in
        getsockname(serverFd, sockaddrPtr, &boundLen)
    }
}
let port = boundAddr.sin_port

let serverThread = Thread {
    let connFd = accept(serverFd, nil, nil)
    var buffer = [UInt8](repeating: 0, count: 64)
    let n = recv(connFd, &buffer, 64, 0)
    _ = buffer.withUnsafeBufferPointer { send(connFd, $0.baseAddress, Int(n), 0) }
    close(connFd)
}
serverThread.start()

// give the server thread a moment to reach accept() before the client connects
Thread.sleep(forTimeInterval: 0.1)
let result = echoOnce(port: port, message: "ping")
close(serverFd)

assert(result == "ping")
print("ok")
