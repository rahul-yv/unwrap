def make_counter
  count = 0
  -> { count += 1 }
end

counter = make_counter
raise "fail" unless counter.call == 1
raise "fail" unless counter.call == 2
raise "fail" unless counter.call == 3

other = make_counter
raise "fail" unless other.call == 1

puts "ok"
