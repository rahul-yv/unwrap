class TestRunner
  def initialize
    @run = 0
    @failed = 0
  end

  def check(condition, name)
    @run += 1
    if condition
      puts "PASS: #{name}"
    else
      @failed += 1
      puts "FAIL: #{name}"
    end
  end

  def summary
    puts "#{@run - @failed}/#{@run} passed"
    @failed.zero? ? 0 : 1
  end
end

def add(a, b) = a + b

t = TestRunner.new
t.check(add(2, 3) == 5, "adds positive numbers")
t.check(add(-2, -3) == -5, "adds negative numbers")
exit_code = t.summary
raise "fail" unless exit_code == 0

puts "ok"
