import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static Map<String, Integer> wordCounts(List<String> words) {
        Map<String, Integer> counts = new HashMap<>();
        for (String word : words) {
            counts.put(word, counts.getOrDefault(word, 0) + 1);
        }
        return counts;
    }

    public static void main(String[] args) {
        Map<String, Integer> result = wordCounts(List.of("a", "b", "a"));
        check(result.get("a") == 2, "a should appear twice");
        check(result.get("b") == 1, "b should appear once");
        System.out.println("ok");
    }
}
