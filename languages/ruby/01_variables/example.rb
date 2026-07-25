age = 25
name = "Ada"
age = age + 1
raise "fail" unless age == 26
raise "fail" unless name == "Ada"

MAX_RETRIES = 3
raise "fail" unless MAX_RETRIES == 3

point = [3, 4]
copy = point.dup
copy[0] = 99
raise "fail" unless point == [3, 4]
raise "fail" unless copy == [99, 4]

puts "ok"
