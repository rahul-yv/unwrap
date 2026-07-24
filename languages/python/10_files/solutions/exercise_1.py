def count_lines(path):
    count = 0
    with open(path, encoding="utf-8") as f:
        for _ in f:
            count += 1
    return count


if __name__ == "__main__":
    import tempfile
    from pathlib import Path

    with tempfile.TemporaryDirectory() as tmp:
        path = Path(tmp) / "notes.txt"
        path.write_text("a\nb\nc\n", encoding="utf-8")
        assert count_lines(path) == 3
    print("ok")
