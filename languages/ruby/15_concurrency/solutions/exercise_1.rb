def sum_concurrently(numbers)
  mid = numbers.length / 2
  left, right = numbers[0...mid], numbers[mid..]

  left_thread = Thread.new { left.sum }
  right_thread = Thread.new { right.sum }

  left_thread.value + right_thread.value
end

raise "fail" unless sum_concurrently([1, 2, 3, 4, 5, 6]) == 21

puts "ok"
