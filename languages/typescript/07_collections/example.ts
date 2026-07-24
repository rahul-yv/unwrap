import assert from "node:assert";

function sumReadonly(values: readonly number[]): number {
  return values.reduce((acc, n) => acc + n, 0);
}

function demo(): void {
  const nums: number[] = [1, 2, 3, 4, 5];
  const squares: number[] = nums.map((n) => n * n);
  assert.deepStrictEqual(squares, [1, 4, 9, 16, 25]);

  const scores: Map<string, number> = new Map([["a", 1]]);
  assert.strictEqual(scores.get("a"), 1);

  const unique: Set<number> = new Set([1, 2, 2, 3]);
  assert.strictEqual(unique.size, 3);

  assert.strictEqual(sumReadonly(nums), 15);

  const frozenPoint: readonly [number, number] = [3, 4];
  assert.deepStrictEqual([...frozenPoint], [3, 4]);

  // readonly is compile-time only: the same underlying array is still
  // mutable through a reference typed without readonly
  const mutableAlias: number[] = nums;
  mutableAlias.push(6);
  assert.strictEqual(nums.length, 6);
}

demo();
console.log("ok");
