import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.stream.Stream;

public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    public static void main(String[] args) throws IOException {
        Path path = Files.createTempFile("unwrap-java-notes", ".txt");

        try {
            Files.writeString(path, "line one\nline two\n");

            String content = Files.readString(path);
            check(content.equals("line one\nline two\n"), "readString should return the full content");

            List<String> lines = Files.readAllLines(path);
            check(lines.size() == 2 && lines.get(0).equals("line one"), "readAllLines should split by line");

            long count;
            try (Stream<String> stream = Files.lines(path)) {
                count = stream.count();
            }
            check(count == 2, "Files.lines should stream the same number of lines");

            boolean threw = false;
            try {
                Files.readString(Path.of(path.getParent().toString(), "definitely-missing.txt"));
            } catch (IOException e) {
                threw = true;
            }
            check(threw, "reading a missing file should throw a checked IOException");
        } finally {
            Files.deleteIfExists(path);
        }

        check(!Files.exists(path), "the file should be deleted");

        System.out.println("ok");
    }
}
