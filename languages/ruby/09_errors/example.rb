class InvalidAmountError < StandardError; end

def withdraw(amount)
  raise InvalidAmountError, "amount cannot be negative" if amount < 0
  amount
end

def divide(a, b)
  a / b
rescue ZeroDivisionError
  -1
end

ensure_ran = false
result = begin
  withdraw(-5)
rescue InvalidAmountError => e
  -1
ensure
  ensure_ran = true
end
raise "fail" unless result == -1
raise "fail" unless ensure_ran

raise "fail" unless withdraw(10) == 10

raise "fail" unless divide(10, 0) == -1
raise "fail" unless divide(10, 2) == 5

puts "ok"
