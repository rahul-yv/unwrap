#include <arpa/inet.h>
#include <assert.h>
#include <netinet/in.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

int send_all(int fd, const char *data, int len) {
    int total_sent = 0;
    while (total_sent < len) {
        ssize_t n = send(fd, data + total_sent, (size_t)(len - total_sent), 0);
        if (n == -1) {
            return -1;
        }
        total_sent += (int)n;
    }
    return 0;
}

int main(void) {
    // set up a loopback client/server pair to exercise send_all
    int server = socket(AF_INET, SOCK_STREAM, 0);
    assert(server != -1);

    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    addr.sin_port = 0;
    assert(bind(server, (struct sockaddr *)&addr, sizeof(addr)) == 0);
    assert(listen(server, 1) == 0);

    struct sockaddr_in bound;
    socklen_t bound_len = sizeof(bound);
    assert(getsockname(server, (struct sockaddr *)&bound, &bound_len) == 0);

    int client = socket(AF_INET, SOCK_STREAM, 0);
    assert(client != -1);

    struct sockaddr_in target;
    memset(&target, 0, sizeof(target));
    target.sin_family = AF_INET;
    target.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    target.sin_port = bound.sin_port;
    assert(connect(client, (struct sockaddr *)&target, sizeof(target)) == 0);

    int conn = accept(server, NULL, NULL);
    assert(conn != -1);

    const char *message = "hello world";
    assert(send_all(client, message, (int)strlen(message)) == 0);

    char buffer[32];
    ssize_t received = recv(conn, buffer, sizeof(buffer) - 1, 0);
    assert(received == (ssize_t)strlen(message));
    buffer[received] = '\0';
    assert(strcmp(buffer, "hello world") == 0);

    close(conn);
    close(client);
    close(server);

    printf("ok\n");
    return 0;
}
