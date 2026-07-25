require "socket"

server = TCPServer.new("127.0.0.1", 0)
port = server.addr[1]

client = TCPSocket.new("127.0.0.1", port)
conn = server.accept

client.write("ping")
received = conn.read(4)
raise "fail" unless received == "ping"

client.close
conn.close
server.close

puts "ok"
