i = 42
f = 3.14
s = "hello"
sym = :active
flag = true
n = nil
raise "fail" unless i == 42 && s == "hello" && sym == :active && flag == true && n.nil?
raise "fail" unless f > 3.1 && f < 3.2

name = nil
length = name&.length
raise "fail" unless length.nil?
length ||= 0
raise "fail" unless length == 0

present = "hi"
raise "fail" unless (present&.length || 0) == 2

ratio = 3 / 2
exact = 3.0 / 2
raise "fail" unless ratio == 1
raise "fail" unless exact == 1.5

big = 10_000_000_000_000_000_000
raise "fail" unless big > 2**63

puts "ok"
