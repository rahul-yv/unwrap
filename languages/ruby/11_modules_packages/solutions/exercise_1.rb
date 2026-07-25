require_relative "../mypackage/helpers"

def example_usage
  MyPackage.greet("World")
end

raise "fail" unless example_usage == "Hello, World!"

puts "ok"
