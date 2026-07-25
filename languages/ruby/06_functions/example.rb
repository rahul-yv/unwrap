def greet(name, greeting: "Hello")
  "#{greeting}, #{name}!"
end

def sum(*numbers)
  numbers.sum
end

def make_counter
  count = 0
  -> { count += 1 }
end

raise "fail" unless greet("Ada") == "Hello, Ada!"
raise "fail" unless greet("Ada", greeting: "Hi") == "Hi, Ada!"

raise "fail" unless sum(1, 2, 3) == 6

add_five = ->(x) { x + 5 }
raise "fail" unless add_five.call(3) == 8

counter = make_counter
raise "fail" unless counter.call == 1
raise "fail" unless counter.call == 2

puts "ok"
