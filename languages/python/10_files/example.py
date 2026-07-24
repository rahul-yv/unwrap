import tempfile
from pathlib import Path


def demo():
    with tempfile.TemporaryDirectory() as tmp:
        path = Path(tmp) / "notes.txt"
        path.write_text("line one\nline two\n", encoding="utf-8")

        with open(path, encoding="utf-8") as f:
            lines = f.readlines()
        assert lines == ["line one\n", "line two\n"]

        content_lines = path.read_text(encoding="utf-8").splitlines()
        assert content_lines == ["line one", "line two"]

        # stream instead of loading everything at once
        count = 0
        with open(path, encoding="utf-8") as f:
            for _ in f:
                count += 1
        assert count == 2

        path.unlink()
        assert not path.exists()


if __name__ == "__main__":
    demo()
    print("ok")
