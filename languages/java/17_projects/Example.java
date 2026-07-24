import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static final Pattern WORD_PATTERN = Pattern.compile("[a-z']+");

    static Map<String, Integer> countWords(String text) {
        Map<String, Integer> counts = new HashMap<>();
        Matcher matcher = WORD_PATTERN.matcher(text.toLowerCase());
        while (matcher.find()) {
            String word = matcher.group();
            counts.put(word, counts.getOrDefault(word, 0) + 1);
        }
        return counts;
    }

    static List<Map.Entry<String, Integer>> topWords(Path path, int n) throws IOException {
        String content;
        try {
            content = Files.readString(path);
        } catch (NoSuchFileException e) {
            throw new IOException("no such file: " + path, e);
        }

        return countWords(content).entrySet().stream()
                .sorted((a, b) -> b.getValue() - a.getValue())
                .limit(n)
                .toList();
    }

    public static void main(String[] args) throws IOException {
        Map<String, Integer> counts = countWords("The cat sat. The cat ran!");
        check(counts.get("the") == 2 && counts.get("cat") == 2, "countWords should count occurrences");

        Path path = Files.createTempFile("unwrap-java-story", ".txt");
        try {
            Files.writeString(path, "dog dog cat bird dog cat");

            List<Map.Entry<String, Integer>> top = topWords(path, 2);
            check(top.size() == 2, "should return 2 entries");
            check(top.get(0).getKey().equals("dog") && top.get(0).getValue() == 3, "dog should be the top word");
            check(top.get(1).getKey().equals("cat") && top.get(1).getValue() == 2, "cat should be second");

            boolean threw = false;
            try {
                topWords(Path.of(path.getParent().toString(), "missing.txt"), 2);
            } catch (IOException e) {
                threw = true;
            }
            check(threw, "topWords should throw a clear IOException for a missing file");
        } finally {
            Files.deleteIfExists(path);
        }

        System.out.println("ok");
    }
}
