#include <arpa/inet.h>
#include <cassert>
#include <cstring>
#include <iostream>
#include <netinet/in.h>
#include <string>
#include <sys/socket.h>
#include <unistd.h>

// RAII wrapper: closes the fd automatically, non-copyable
class Socket {
public:
    explicit Socket(int fd) : fd_(fd) {}
    ~Socket() {
        if (fd_ >= 0) {
            ::close(fd_);
        }
    }
    Socket(const Socket&) = delete;
    Socket& operator=(const Socket&) = delete;
    int get() const { return fd_; }

private:
    int fd_;
};

int main() {
    Socket server(::socket(AF_INET, SOCK_STREAM, 0));
    assert(server.get() != -1);

    sockaddr_in addr{};
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    addr.sin_port = 0;
    assert(::bind(server.get(), reinterpret_cast<sockaddr*>(&addr), sizeof(addr)) == 0);
    assert(::listen(server.get(), 1) == 0);

    sockaddr_in bound{};
    socklen_t bound_len = sizeof(bound);
    assert(::getsockname(server.get(), reinterpret_cast<sockaddr*>(&bound), &bound_len) == 0);

    Socket client(::socket(AF_INET, SOCK_STREAM, 0));
    assert(client.get() != -1);

    sockaddr_in target{};
    target.sin_family = AF_INET;
    target.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    target.sin_port = bound.sin_port;
    assert(::connect(client.get(), reinterpret_cast<sockaddr*>(&target), sizeof(target)) == 0);

    Socket conn(::accept(server.get(), nullptr, nullptr));
    assert(conn.get() != -1);

    std::string message = "ping";
    assert(::send(client.get(), message.data(), message.size(), 0) ==
           static_cast<ssize_t>(message.size()));

    char buffer[16];
    ssize_t received = ::recv(conn.get(), buffer, sizeof(buffer) - 1, 0);
    assert(received == 4);
    buffer[received] = '\0';
    assert(std::string(buffer) == "ping");

    // sockets close automatically as the Socket objects go out of scope here
    std::cout << "ok\n";
    return 0;
}
