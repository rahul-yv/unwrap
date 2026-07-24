import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;

public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static long countLines(Path path) throws IOException {
        try (Stream<String> stream = Files.lines(path)) {
            return stream.count();
        }
    }

    public static void main(String[] args) throws IOException {
        Path path = Files.createTempFile("unwrap-java-count", ".txt");
        try {
            Files.writeString(path, "a\nb\nc\n");
            check(countLines(path) == 3, "countLines should return 3");
        } finally {
            Files.deleteIfExists(path);
        }
        System.out.println("ok");
    }
}
