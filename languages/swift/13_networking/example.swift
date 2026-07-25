#if canImport(Glibc)
import Glibc
let streamSocketType = Int32(SOCK_STREAM.rawValue)
#else
import Darwin
let streamSocketType = SOCK_STREAM
#endif

func makeSocket() -> Int32 {
    socket(AF_INET, streamSocketType, 0)
}

let serverFd = makeSocket()
assert(serverFd >= 0)

var addr = sockaddr_in()
addr.sin_family = sa_family_t(AF_INET)
addr.sin_addr.s_addr = inet_addr("127.0.0.1")
addr.sin_port = 0

let bindResult = withUnsafePointer(to: &addr) { ptr -> Int32 in
    ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockaddrPtr in
        bind(serverFd, sockaddrPtr, socklen_t(MemoryLayout<sockaddr_in>.size))
    }
}
assert(bindResult == 0)
assert(listen(serverFd, 1) == 0)

var boundAddr = sockaddr_in()
var boundLen = socklen_t(MemoryLayout<sockaddr_in>.size)
_ = withUnsafeMutablePointer(to: &boundAddr) { ptr -> Int32 in
    ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockaddrPtr in
        getsockname(serverFd, sockaddrPtr, &boundLen)
    }
}

let clientFd = makeSocket()
var target = sockaddr_in()
target.sin_family = sa_family_t(AF_INET)
target.sin_addr.s_addr = inet_addr("127.0.0.1")
target.sin_port = boundAddr.sin_port

let connectResult = withUnsafePointer(to: &target) { ptr -> Int32 in
    ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockaddrPtr in
        connect(clientFd, sockaddrPtr, socklen_t(MemoryLayout<sockaddr_in>.size))
    }
}
assert(connectResult == 0)

let connFd = accept(serverFd, nil, nil)
assert(connFd >= 0)

let message = "ping"
_ = message.withCString { send(clientFd, $0, strlen($0), 0) }

var buffer = [UInt8](repeating: 0, count: 16)
let received = recv(connFd, &buffer, 16, 0)
assert(received == 4)
let text = String(decoding: buffer[0..<Int(received)], as: UTF8.self)
assert(text == "ping")

close(clientFd)
close(connFd)
close(serverFd)

print("ok")
