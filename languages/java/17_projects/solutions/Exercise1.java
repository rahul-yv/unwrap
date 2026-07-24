import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static final Pattern WORD_PATTERN = Pattern.compile("[a-z']+");

    static List<Map.Entry<String, Integer>> topWordsExcluding(Path path, int n, Set<String> stopwords) throws IOException {
        String content = Files.readString(path);
        Map<String, Integer> counts = new HashMap<>();
        Matcher matcher = WORD_PATTERN.matcher(content.toLowerCase());
        while (matcher.find()) {
            String word = matcher.group();
            if (stopwords.contains(word)) {
                continue;
            }
            counts.put(word, counts.getOrDefault(word, 0) + 1);
        }

        return counts.entrySet().stream()
                .sorted((a, b) -> b.getValue() - a.getValue())
                .limit(n)
                .toList();
    }

    public static void main(String[] args) throws IOException {
        Path path = Files.createTempFile("unwrap-java-stop", ".txt");
        try {
            Files.writeString(path, "the cat the dog the dog bird");

            List<Map.Entry<String, Integer>> result = topWordsExcluding(path, 2, Set.of("the"));
            check(result.size() == 2, "should return 2 entries");
            check(result.get(0).getKey().equals("dog") && result.get(0).getValue() == 2, "dog should be first");
        } finally {
            Files.deleteIfExists(path);
        }

        System.out.println("ok");
    }
}
