total = 0
5.times { |i| total += i }
raise "fail" unless total == 10

descending = []
5.step(1, -2) { |i| descending << i }
raise "fail" unless descending == [5, 3, 1]

items = ["a", "b", "c"]
indexed = []
items.each_with_index { |value, index| indexed << "#{index}:#{value}" }
raise "fail" unless indexed == ["0:a", "1:b", "2:c"]

count = 0
count += 1 while count < 3
raise "fail" unless count == 3

numbers = [1, 2, 3, 4, 5]
evens_doubled = numbers.select(&:even?).map { |n| n * 2 }
raise "fail" unless evens_doubled == [4, 8]

collected = []
numbers.each do |n|
  next if n.odd?
  break if n > 4
  collected << n
end
raise "fail" unless collected == [2, 4]

puts "ok"
