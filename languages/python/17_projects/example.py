import re
from collections import Counter
from pathlib import Path

WORD_RE = re.compile(r"[a-z']+")


def count_words(text):
    return Counter(WORD_RE.findall(text.lower()))


def top_words(path, n):
    path = Path(path)
    if not path.exists():
        raise FileNotFoundError(f"no such file: {path}")

    counts = count_words(path.read_text(encoding="utf-8"))
    return counts.most_common(n)


def demo():
    import tempfile

    assert count_words("The cat sat. The cat ran!") == Counter(
        {"the": 2, "cat": 2, "sat": 1, "ran": 1}
    )

    with tempfile.TemporaryDirectory() as tmp:
        path = Path(tmp) / "story.txt"
        path.write_text("dog dog cat bird dog cat", encoding="utf-8")

        assert top_words(path, 2) == [("dog", 3), ("cat", 2)]

        try:
            top_words(Path(tmp) / "missing.txt", 2)
            assert False, "expected FileNotFoundError"
        except FileNotFoundError:
            pass


if __name__ == "__main__":
    demo()
    print("ok")
