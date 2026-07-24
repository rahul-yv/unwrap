import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static List<List<String>> groupAnagrams(String[] words) {
        Map<String, List<String>> groups = new HashMap<>();
        for (String word : words) {
            char[] chars = word.toCharArray();
            Arrays.sort(chars);
            String key = new String(chars);
            groups.computeIfAbsent(key, k -> new ArrayList<>()).add(word);
        }
        return new ArrayList<>(groups.values());
    }

    public static void main(String[] args) {
        List<List<String>> result = groupAnagrams(new String[] {"eat", "tea", "tan", "ate", "nat", "bat"});
        check(result.size() == 3, "should produce 3 groups");

        int totalWords = 0;
        for (List<String> group : result) {
            totalWords += group.size();
        }
        check(totalWords == 6, "every input word should appear in exactly one group");

        System.out.println("ok");
    }
}
