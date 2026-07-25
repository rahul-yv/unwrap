def two_sum(nums, target)
  seen = {}
  nums.each_with_index do |n, i|
    complement = target - n
    return [seen[complement], i] if seen.key?(complement)
    seen[n] = i
  end
  nil
end

def palindrome?(s)
  chars = s.downcase.gsub(/[^a-z0-9]/, "")
  chars == chars.reverse
end

def merge_intervals(intervals)
  return [] if intervals.empty?

  sorted = intervals.sort_by { |interval| interval[0] }
  merged = [sorted[0].dup]

  sorted[1..].each do |interval|
    last = merged[-1]
    if interval[0] <= last[1]
      last[1] = [last[1], interval[1]].max
    else
      merged << interval.dup
    end
  end
  merged
end

raise "fail" unless two_sum([2, 7, 11, 15], 9) == [0, 1]
raise "fail" unless two_sum([1, 2], 100).nil?

raise "fail" unless palindrome?("A man, a plan, a canal: Panama")
raise "fail" if palindrome?("race a car")

merged = merge_intervals([[1, 3], [2, 6], [8, 10], [15, 18]])
raise "fail" unless merged == [[1, 6], [8, 10], [15, 18]]
raise "fail" unless merge_intervals([]) == []

puts "ok"
