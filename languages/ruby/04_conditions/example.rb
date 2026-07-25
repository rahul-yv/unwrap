def describe(value)
  case value
  when Integer then "an Integer: #{value}"
  when String then "a String of length #{value.length}"
  when nil then "nil"
  else "something else"
  end
end

age = 20
category = if age < 13 then "child" elsif age < 20 then "teen" else "adult" end
raise "fail" unless category == "adult"

x = 5
description = case
              when x < 0 then "negative"
              when x == 0 then "zero"
              when x.even? then "positive even"
              else "positive odd"
              end
raise "fail" unless description == "positive odd"

raise "fail" unless describe(42) == "an Integer: 42"
raise "fail" unless describe("hi") == "a String of length 2"
raise "fail" unless describe(nil) == "nil"

puts "ok"
