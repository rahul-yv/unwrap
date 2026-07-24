import assert from "node:assert";

function greet(name: string, greeting: string = "Hello"): string {
  return `${greeting}, ${name}!`;
}

function identity<T>(value: T): T {
  return value;
}

function wrap<T>(value: T): T[] {
  return [value];
}

function parseInput(value: string): number;
function parseInput(value: number): number;
function parseInput(value: string | number): number {
  return typeof value === "string" ? parseInt(value, 10) : value;
}

function demo(): void {
  assert.strictEqual(greet("Ada"), "Hello, Ada!");
  assert.strictEqual(greet("Ada", "Hi"), "Hi, Ada!");

  assert.strictEqual(identity<number>(5), 5);
  assert.strictEqual(identity("hello"), "hello");

  assert.deepStrictEqual(wrap(5), [5]);
  assert.deepStrictEqual(wrap("x"), ["x"]);

  assert.strictEqual(parseInput("42"), 42);
  assert.strictEqual(parseInput(42), 42);
}

demo();
console.log("ok");
