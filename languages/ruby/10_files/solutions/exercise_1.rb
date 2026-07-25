require "tmpdir"

def count_lines(path)
  count = 0
  File.open(path) do |file|
    file.each_line { |_line| count += 1 }
  end
  count
end

path = File.join(Dir.tmpdir, "unwrap-#{Process.pid}.txt")
File.write(path, "a\nb\nc\n")

raise "fail" unless count_lines(path) == 3

File.delete(path)
puts "ok"
