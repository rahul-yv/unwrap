import java.net.InetAddress
import java.net.ServerSocket
import java.net.Socket

fun main() {
    val server = ServerSocket(0, 1, InetAddress.getLoopbackAddress())
    val port = server.localPort

    val serverThread = Thread {
        server.accept().use { conn ->
            val buffer = ByteArray(16)
            val read = conn.getInputStream().read(buffer)
            conn.getOutputStream().write(buffer, 0, read)
        }
    }
    serverThread.start()

    var text = ""
    Socket(InetAddress.getLoopbackAddress(), port).use { client ->
        client.getOutputStream().write("ping".toByteArray())

        val response = ByteArray(16)
        val n = client.getInputStream().read(response)
        text = String(response, 0, n)
    }
    serverThread.join()
    server.close()

    check(text == "ping")
    println("ok")
}
