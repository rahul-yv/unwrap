def safe_parse_int(s)
  Integer(s)
rescue ArgumentError
  nil
end

raise "fail" unless safe_parse_int("42") == 42
raise "fail" unless safe_parse_int("not a number").nil?

puts "ok"
