def sum_evens(n)
  (0..n).select(&:even?).sum
end

raise "fail" unless sum_evens(10) == 30
raise "fail" unless sum_evens(0) == 0

puts "ok"
