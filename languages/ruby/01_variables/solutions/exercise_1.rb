def swap(a, b)
  [b, a]
end

x, y = swap(1, 2)
raise "fail" unless x == 2 && y == 1

puts "ok"
