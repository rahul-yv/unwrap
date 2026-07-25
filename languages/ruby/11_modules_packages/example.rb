require_relative "mypackage/helpers"

raise "fail" unless MyPackage.greet("Ada") == "Hello, Ada!"

puts "ok"
