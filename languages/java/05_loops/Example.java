import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    public static void main(String[] args) {
        int[] seen = new int[3];
        for (int i = 0; i < 3; i++) {
            seen[i] = i;
        }
        check(seen[0] == 0 && seen[2] == 2, "classic for should collect 0,1,2");

        StringBuilder collected = new StringBuilder();
        for (String item : new String[] {"a", "b", "c"}) {
            collected.append(item);
        }
        check(collected.toString().equals("abc"), "for-each should visit every element in order");

        int n = 0;
        while (n < 3) {
            n++;
        }
        check(n == 3, "while should behave as expected");

        int count = 0;
        do {
            count++;
        } while (false);
        check(count == 1, "do-while should run the body at least once even if condition is false");

        List<Integer> list = new ArrayList<>(List.of(1, 2, 3, 4));
        boolean threw = false;
        try {
            for (Integer item : list) {
                if (item == 2) {
                    list.remove(item); // mutating during for-each, with more elements still to visit
                }
            }
        } catch (java.util.ConcurrentModificationException e) {
            threw = true;
        }
        check(threw, "mutating a list during for-each should throw ConcurrentModificationException");

        List<Integer> safeList = new ArrayList<>(List.of(1, 2, 3));
        Iterator<Integer> it = safeList.iterator();
        while (it.hasNext()) {
            if (it.next() == 2) {
                it.remove(); // safe: removing via the iterator itself
            }
        }
        check(safeList.size() == 2 && !safeList.contains(2), "Iterator.remove() should safely remove during iteration");

        System.out.println("ok");
    }
}
