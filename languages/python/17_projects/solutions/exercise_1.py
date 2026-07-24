import re
import sys
import tempfile
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

WORD_RE = re.compile(r"[a-z']+")


def top_words_excluding(path, n, stopwords):
    path = Path(path)
    if not path.exists():
        raise FileNotFoundError(f"no such file: {path}")

    words = (w for w in WORD_RE.findall(path.read_text(encoding="utf-8").lower()) if w not in stopwords)
    return Counter(words).most_common(n)


if __name__ == "__main__":
    with tempfile.TemporaryDirectory() as tmp:
        path = Path(tmp) / "story.txt"
        path.write_text("the cat the dog the dog bird", encoding="utf-8")

        assert top_words_excluding(path, 2, {"the"}) == [("dog", 2), ("cat", 1)]

    print("ok")
