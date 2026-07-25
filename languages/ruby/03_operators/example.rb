class Point
  attr_reader :x, :y
  def initialize(x, y) = (@x, @y = x, y)

  def +(other) = Point.new(x + other.x, y + other.y)
  def ==(other) = other.is_a?(Point) && x == other.x && y == other.y
end

sum = 3 + 4
remainder = 10 % 3
raise "fail" unless sum == 7 && remainder == 1

in_range = (1..10).include?(5)
not_in_range = !(1..10).include?(15)
raise "fail" unless in_range && not_in_range

a = true
b = false
raise "fail" unless (a && b) == false
raise "fail" unless (a || b) == true

x = nil
y = x || -1
raise "fail" unless y == -1

p = Point.new(1, 2) + Point.new(3, 4)
raise "fail" unless p == Point.new(4, 6)

puts "ok"
