def group_anagrams(words)
  words.group_by { |word| word.chars.sort.join }.values
end

words = ["eat", "tea", "tan", "ate", "nat", "bat"]
groups = group_anagrams(words)

raise "fail" unless groups.length == 3
raise "fail" unless groups.any? { |g| g.sort == ["ate", "eat", "tea"] }
raise "fail" unless groups.any? { |g| g.sort == ["nat", "tan"] }
raise "fail" unless groups.any? { |g| g == ["bat"] }

puts "ok"
