require "tmpdir"

def count_words(text)
  text.downcase.scan(/[a-z']+/).tally
end

def top_words_excluding(path, n, stopwords)
  content = File.read(path)
  counts = count_words(content).reject { |word, _count| stopwords.include?(word) }
  counts.sort_by { |_word, count| -count }.first(n)
end

path = File.join(Dir.tmpdir, "unwrap-ruby-stopwords-#{Process.pid}.txt")
File.write(path, "the dog and the cat and the bird")

top = top_words_excluding(path, 2, ["the", "and"])

raise "fail" unless top.length == 2
raise "fail" unless top.all? { |_word, count| count == 1 }

File.delete(path)

puts "ok"
