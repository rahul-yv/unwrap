import assert from "node:assert";

function groupAnagrams(words: string[]): string[][] {
  const groups = new Map<string, string[]>();
  for (const word of words) {
    const key = word.split("").sort().join("");
    const group = groups.get(key);
    if (group) {
      group.push(word);
    } else {
      groups.set(key, [word]);
    }
  }
  return [...groups.values()];
}

const result = groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]);
const resultAsSets = new Set(result.map((group) => [...group].sort().join(",")));
const expected = new Set([["ate", "eat", "tea"].join(","), ["nat", "tan"].join(","), ["bat"].join(",")]);
assert.deepStrictEqual(resultAsSets, expected);

console.log("ok");
