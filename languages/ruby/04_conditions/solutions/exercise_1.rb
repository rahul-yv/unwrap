def grade(score)
  case score
  when 90.. then "A"
  when 80...90 then "B"
  when 70...80 then "C"
  else "F"
  end
end

raise "fail" unless grade(95) == "A"
raise "fail" unless grade(85) == "B"
raise "fail" unless grade(75) == "C"
raise "fail" unless grade(50) == "F"

puts "ok"
