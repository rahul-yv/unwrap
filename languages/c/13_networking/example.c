#include <arpa/inet.h>
#include <assert.h>
#include <netinet/in.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

int main(void) {
    // create a listening TCP socket on 127.0.0.1, OS-assigned port
    int server = socket(AF_INET, SOCK_STREAM, 0);
    assert(server != -1);

    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    addr.sin_port = 0; // let the OS pick a free port

    assert(bind(server, (struct sockaddr *)&addr, sizeof(addr)) == 0);
    assert(listen(server, 1) == 0);

    // read back the port the OS actually assigned
    struct sockaddr_in bound;
    socklen_t bound_len = sizeof(bound);
    assert(getsockname(server, (struct sockaddr *)&bound, &bound_len) == 0);

    // connect a client to it
    int client = socket(AF_INET, SOCK_STREAM, 0);
    assert(client != -1);

    struct sockaddr_in target;
    memset(&target, 0, sizeof(target));
    target.sin_family = AF_INET;
    target.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    target.sin_port = bound.sin_port;
    assert(connect(client, (struct sockaddr *)&target, sizeof(target)) == 0);

    // server accepts and receives
    int conn = accept(server, NULL, NULL);
    assert(conn != -1);

    const char *message = "ping";
    assert(send(client, message, strlen(message), 0) == (ssize_t)strlen(message));

    char buffer[16];
    ssize_t received = recv(conn, buffer, sizeof(buffer) - 1, 0);
    assert(received == 4);
    buffer[received] = '\0';
    assert(strcmp(buffer, "ping") == 0);

    close(conn);
    close(client);
    close(server);

    printf("ok\n");
    return 0;
}
