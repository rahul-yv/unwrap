import java.util.function.Supplier;

public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static Supplier<Integer> makeCounter() {
        int[] count = {0};
        return () -> ++count[0];
    }

    public static void main(String[] args) {
        Supplier<Integer> counter = makeCounter();
        check(counter.get() == 1, "first call should return 1");
        check(counter.get() == 2, "second call should return 2");
        check(counter.get() == 3, "third call should return 3");

        Supplier<Integer> other = makeCounter();
        check(other.get() == 1, "a new counter should have independent state");

        System.out.println("ok");
    }
}
