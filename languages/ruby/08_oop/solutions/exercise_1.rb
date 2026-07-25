class Circle
  include Comparable
  attr_reader :radius

  def initialize(radius) = @radius = radius
  def area = Math::PI * radius**2
  def <=>(other) = area <=> other.area
end

raise "fail" unless Circle.new(1) < Circle.new(2)
raise "fail" unless Circle.new(2) > Circle.new(1)
raise "fail" unless Circle.new(1) == Circle.new(1)

puts "ok"
