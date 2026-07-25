numbers = [1, 2, 3, 4, 5]

doubled = numbers.map { |n| n * 2 }
raise "fail" unless doubled == [2, 4, 6, 8, 10]

evens = numbers.select(&:even?)
raise "fail" unless evens == [2, 4]

total = numbers.reduce(0) { |acc, n| acc + n }
raise "fail" unless total == 15

ages = { "Ada" => 36, "Grace" => 85 }
raise "fail" unless ages["Ada"] == 36
raise "fail" unless ages.fetch("Nobody", 0) == 0

frozen = [1, 2, 3].freeze
begin
  frozen << 4
  raise "fail"
rescue FrozenError
  # expected
end

lazy_result = (1..Float::INFINITY).lazy.map { |n| n * 2 }.select { |n| n > 4 }.first
raise "fail" unless lazy_result == 6

puts "ok"
