# Modules and Packages

Ruby loads other files with `require` (searches `$LOAD_PATH`, used for gems and stdlib) or `require_relative` (resolves relative to the current file, used for your own project's files). Namespacing uses **modules** — `module MyPackage; def self.greet(name); ...; end; end` groups related code under `MyPackage::greet`, preventing name collisions the same way Java/C# namespaces or Python packages do. Real-world Ruby projects typically use **Bundler** and **RubyGems** for dependency management, and Rails-style autoloading (Zeitwerk) to avoid manual `require` calls entirely for a project's own classes.

## Example

```ruby
# mypackage/helpers.rb
module MyPackage
  def self.greet(name)
    "Hello, #{name}!"
  end
end
```

```ruby
# using it — example.rb
require_relative "mypackage/helpers"

MyPackage.greet("Ada")
```

See [`example.rb`](./example.rb) and [`mypackage/`](./mypackage/) for the full runnable files.

## Common mistakes

1. **Using `require` for a file that's part of the same project instead of `require_relative`.** `require` resolves against `$LOAD_PATH` (which may or may not include the current directory depending on how the script is invoked) — `require_relative` always resolves relative to the requiring file's own location, making it reliable regardless of the working directory the script was launched from.
2. **Not namespacing code inside a module and relying on globally unique method/class names** — without a module, two files each defining `format` at the top level collide; wrapping in `module MyPackage; def self.format(...); end; end` scopes it to `MyPackage.format`, avoiding the clash.
3. **Requiring the same file from multiple different files without either using `require` (which tracks and skips already-loaded files) or being careful about load order.** Unlike `load` (which always re-executes the file), `require` (and `require_relative`) both track loaded files and won't re-run them — this is usually the desired behavior and rarely causes issues, but it's worth knowing `load` exists for the rare case where re-execution is actually wanted.
4. **Manually `require_relative`-ing every file in a larger project instead of using Bundler/autoloading conventions** — becomes unwieldy and error-prone (missing or misordered requires) as a project grows past a handful of files; real projects lean on `Bundler.require` and autoloading frameworks instead.

## Exercise

Using `mypackage/helpers.rb`'s `MyPackage.greet`, write `def example_usage` in `solutions/exercise_1.rb` returning `MyPackage.greet("World")`.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **What's the difference between `require` and `require_relative`?** — `require` looks for the file along `$LOAD_PATH` (a list of directories, including where installed gems live) — the standard way to load stdlib and third-party gems. `require_relative` resolves the path relative to the file calling it, regardless of the current working directory — the standard way to load your own project's files, since it doesn't depend on how or from where the script was launched.
2. **What problem do Ruby modules solve when used for namespacing?** — Ruby has one global namespace for top-level constants and methods by default — two libraries each defining a `Parser` class or a `format` method at the top level would collide. Wrapping definitions in a module (`module MyLib; class Parser; ...; end; end`) scopes them under `MyLib::Parser`, letting unrelated libraries define similarly-named things without conflict.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)
