import java.net.InetAddress
import java.net.ServerSocket
import java.net.Socket

fun echoOnce(port: Int, message: String): String {
    Socket(InetAddress.getLoopbackAddress(), port).use { client ->
        client.getOutputStream().write(message.toByteArray())
        val response = ByteArray(64)
        val n = client.getInputStream().read(response)
        return String(response, 0, n)
    }
}

fun main() {
    val server = ServerSocket(0, 1, InetAddress.getLoopbackAddress())
    val port = server.localPort

    val serverThread = Thread {
        server.accept().use { conn ->
            val buffer = ByteArray(64)
            val read = conn.getInputStream().read(buffer)
            conn.getOutputStream().write(buffer, 0, read)
        }
    }
    serverThread.start()

    val result = echoOnce(port, "ping")
    serverThread.join()
    server.close()

    check(result == "ping")
    println("ok")
}
