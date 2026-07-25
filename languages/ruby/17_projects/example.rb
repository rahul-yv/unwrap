require "tmpdir"

def count_words(text)
  text.downcase.scan(/[a-z']+/).tally
end

def top_words(path, n)
  content = File.read(path)
  counts = count_words(content)
  counts.sort_by { |_word, count| -count }.first(n)
end

counts = count_words("The cat sat. The cat ran!")
raise "fail" unless counts["the"] == 2
raise "fail" unless counts["cat"] == 2

path = File.join(Dir.tmpdir, "unwrap-ruby-story-#{Process.pid}.txt")
File.write(path, "dog dog cat bird dog cat")

top = top_words(path, 2)
raise "fail" unless top == [["dog", 3], ["cat", 2]]

threw = false
begin
  top_words("/tmp/unwrap-ruby-missing-#{Process.pid}.txt", 2)
rescue Errno::ENOENT
  threw = true
end
raise "fail" unless threw

File.delete(path)

puts "ok"
