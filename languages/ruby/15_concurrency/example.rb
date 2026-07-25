counter = 0
mutex = Mutex.new

threads = 10.times.map do
  Thread.new do
    mutex.synchronize { counter += 1 }
  end
end
threads.each(&:join)
raise "fail" unless counter == 10

ractor = Ractor.new { 1 + 2 }
result = ractor.value
raise "fail" unless result == 3

puts "ok"
