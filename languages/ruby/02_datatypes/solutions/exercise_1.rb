def safe_length(s)
  s&.length || 0
end

raise "fail" unless safe_length(nil) == 0
raise "fail" unless safe_length("hello") == 5

puts "ok"
