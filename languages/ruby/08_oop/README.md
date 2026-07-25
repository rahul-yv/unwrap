# Object-Oriented Programming

Ruby classes support single inheritance, and **modules** provide Ruby's answer to the lack of multiple inheritance: `include` mixes a module's instance methods into a class (added to its ancestor chain), `extend` mixes them in as class/singleton methods. `attr_accessor`/`attr_reader`/`attr_writer` generate getter/setter methods, avoiding boilerplate. `Comparable` and `Enumerable` are the two most commonly mixed-in standard modules — implement `<=>` or `each` respectively, and get a whole family of methods for free.

## Example

```ruby
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
  def <=>(other) = cents <=> other.cents   # Comparable derives <, >, ==, between?, etc. from this
end

ada = Person.new("Ada")
ada.greet   # "Hello, Ada!"

Money.new(100) < Money.new(200)   # true, via Comparable
```

See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Reaching for inheritance where a module mixin would be more appropriate.** Ruby supports only single inheritance for classes — if behavior needs to be shared across unrelated classes (not a genuine "is-a" relationship), a module (`include`) is the idiomatic tool, not forcing an artificial class hierarchy.
2. **Implementing every comparison method (`<`, `>`, `==`, etc.) by hand instead of defining `<=>` and including `Comparable`.** One `<=>` implementation plus `include Comparable` derives the whole family automatically — duplicating each comparison manually is more code and more chances for an inconsistency between them.
3. **Using `attr_accessor` for a property that should be read-only from outside the class.** `attr_accessor` generates both a getter and setter — if external code should never reassign the property directly, `attr_reader` (getter only) documents that intent and prevents accidental external mutation.
4. **Confusing `include` (adds instance methods) with `extend` (adds class-level/singleton methods).** `include Greetable` in a class makes `greet` available on *instances*; `extend Greetable` in the same class would make `greet` available on the *class itself* — mixing them up is a common source of `NoMethodError`.

## Exercise

Write a class `Circle` with a `radius` and an `area` method (`Math::PI * radius**2`), implementing `<=>` to compare by area and including `Comparable` so two circles can be compared with `<`/`>`/`==`.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **What's the difference between `include` and `extend` in Ruby?** — `include Module` inserts the module into a class's ancestor chain, making its methods available as *instance* methods on objects of that class. `extend Module` adds the module's methods directly to the *receiver's singleton class* — when called on a class itself (`extend` inside a class body), this makes the module's methods available as *class* methods instead.
2. **How does including `Comparable` (after defining `<=>`) reduce boilerplate?** — `Comparable` is implemented in terms of a single method, `<=>`, which a class provides to compare two of its instances (returning -1/0/1). Once that's defined, `include Comparable` automatically derives `<`, `<=`, `==`, `>=`, `>`, and `.between?`/`.clamp` — instead of hand-writing and maintaining each comparison operator (and risking them becoming inconsistent with each other) individually.

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)
