def word_lengths(words)
  words.to_h { |w| [w, w.length] }
end

result = word_lengths(["a", "bb", "ccc"])
raise "fail" unless result == { "a" => 1, "bb" => 2, "ccc" => 3 }

puts "ok"
