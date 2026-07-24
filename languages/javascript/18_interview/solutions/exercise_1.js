const assert = require("assert");

function groupAnagrams(words) {
  const groups = new Map();
  for (const word of words) {
    const key = word.split("").sort().join("");
    if (!groups.has(key)) groups.set(key, []);
    groups.get(key).push(word);
  }
  return [...groups.values()];
}

const result = groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]);
const resultAsSets = new Set(result.map((group) => [...group].sort().join(",")));
const expected = new Set([["ate", "eat", "tea"].join(","), ["nat", "tan"].join(","), ["bat"].join(",")]);
assert.deepStrictEqual(resultAsSets, expected);

assert.deepStrictEqual(groupAnagrams([]), []);
console.log("ok");
