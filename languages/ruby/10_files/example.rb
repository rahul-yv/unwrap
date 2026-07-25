require "tmpdir"

path = File.join(Dir.tmpdir, "unwrap-#{Process.pid}.txt")

File.write(path, "line one\nline two\n")

content = File.read(path)
raise "fail" unless content == "line one\nline two\n"

lines = File.readlines(path, chomp: true)
raise "fail" unless lines == ["line one", "line two"]

File.write(path, "line three\n", mode: "a")
raise "fail" unless File.readlines(path, chomp: true) == ["line one", "line two", "line three"]

line_count = 0
File.open(path) do |file|
  file.each_line { |_line| line_count += 1 }
end
raise "fail" unless line_count == 3

File.delete(path)
raise "fail" if File.exist?(path)

puts "ok"
