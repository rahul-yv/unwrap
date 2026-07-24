import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    public static void main(String[] args) {
        List<Integer> nums = new ArrayList<>(List.of(1, 2, 3, 4, 5));
        List<Integer> squares = nums.stream().map(n -> n * n).toList();
        check(squares.equals(List.of(1, 4, 9, 16, 25)), "stream map should square every element");

        Map<String, Integer> scores = new HashMap<>();
        scores.put("a", 1);
        check(scores.get("a") == 1, "get should return the stored value");
        check(scores.get("z") == null, "get on a missing key should return null");
        check(scores.getOrDefault("z", 0) == 0, "getOrDefault should return the fallback");

        Set<Integer> unique = new HashSet<>(List.of(1, 2, 2, 3));
        check(unique.size() == 3, "Set should collapse duplicates");

        boolean threw = false;
        try {
            List.of(1, 2, 3).add(4);
        } catch (UnsupportedOperationException e) {
            threw = true;
        }
        check(threw, "List.of() should be immutable");

        List<Integer> mutableCopy = new ArrayList<>(List.of(1, 2, 3));
        mutableCopy.add(4);
        check(mutableCopy.size() == 4, "a new ArrayList wrapping List.of() should be mutable");

        check(List.of(1, 2, 3).equals(new ArrayList<>(List.of(1, 2, 3))), "equals() should compare contents, not identity");

        System.out.println("ok");
    }
}
