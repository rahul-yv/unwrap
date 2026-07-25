counter = 0
mutex = Mutex.new

threads = 10.times.map do
  Thread.new do
    mutex.synchronize { counter += 1 }
  end
end
threads.each(&:join)
raise "fail" unless counter == 10

puts "ok"
