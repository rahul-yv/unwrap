module Greetable
  def greet
    "Hello, #{name}!"
  end
end

class Person
  include Greetable
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Money
  include Comparable
  attr_reader :cents

  def initialize(cents) = @cents = cents
  def <=>(other) = cents <=> other.cents
end

ada = Person.new("Ada")
raise "fail" unless ada.greet == "Hello, Ada!"

raise "fail" unless Money.new(100) < Money.new(200)
raise "fail" unless Money.new(200) > Money.new(100)
raise "fail" unless Money.new(100) == Money.new(100)

puts "ok"
