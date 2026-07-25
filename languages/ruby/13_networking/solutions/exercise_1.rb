require "socket"

def echo_once(port, message)
  client = TCPSocket.new("127.0.0.1", port)
  client.write(message)
  response = client.read(message.bytesize)
  client.close
  response
end

server = TCPServer.new("127.0.0.1", 0)
port = server.addr[1]

server_thread = Thread.new do
  conn = server.accept
  received = conn.read(4)
  conn.write(received)
  conn.close
end

result = echo_once(port, "ping")
server_thread.join
server.close

raise "fail" unless result == "ping"

puts "ok"
