import assert from "node:assert";

interface User {
  id: number;
  name: string;
  email?: string;
}

type Status = "pending" | "active" | "closed";

enum Direction {
  Up,
  Down,
  Left,
  Right,
}

function describeStatus(status: Status): string {
  return `status is ${status}`;
}

function demo(): void {
  const user: User = { id: 1, name: "Ada" };
  assert.strictEqual(user.email, undefined);

  const coordinates: [number, number] = [3, 4];
  assert.strictEqual(coordinates[0], 3);
  assert.strictEqual(coordinates.length, 2);

  assert.strictEqual(describeStatus("active"), "status is active");

  assert.strictEqual(Direction.Up, 0);
  assert.strictEqual(Direction[0], "Up"); // numeric enums support reverse mapping

  const widened = [3, 4]; // inferred number[], not a fixed-length tuple
  widened.push(5); // allowed, since it's just number[]
  assert.strictEqual(widened.length, 3);
}

demo();
console.log("ok");
