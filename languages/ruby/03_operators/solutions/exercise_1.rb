def clamp(value, min, max)
  [[value, min].max, max].min
end

raise "fail" unless clamp(5, 0, 10) == 5
raise "fail" unless clamp(-5, 0, 10) == 0
raise "fail" unless clamp(15, 0, 10) == 10

puts "ok"
