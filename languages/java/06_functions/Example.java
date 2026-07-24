import java.util.function.Function;
import java.util.function.Supplier;

public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static String greet(String name) {
        return greet(name, "Hello");
    }

    static String greet(String name, String greeting) {
        return greeting + ", " + name + "!";
    }

    static int sum(int... nums) {
        int total = 0;
        for (int n : nums) {
            total += n;
        }
        return total;
    }

    public static void main(String[] args) {
        check(greet("Ada").equals("Hello, Ada!"), "single-arg overload should use default greeting");
        check(greet("Ada", "Hi").equals("Hi, Ada!"), "two-arg overload should use given greeting");

        check(sum(1, 2, 3) == 6, "varargs should sum all arguments");
        check(sum() == 0, "varargs should accept zero arguments");

        Function<Integer, Integer> doubleIt = x -> x * 2;
        check(doubleIt.apply(5) == 10, "lambda should double its input");

        Supplier<String> supplier = () -> "supplied";
        check(supplier.get().equals("supplied"), "Supplier should produce a value with no input");

        int[] mutableCount = {0};
        Supplier<Integer> counter = () -> ++mutableCount[0];
        check(counter.get() == 1 && counter.get() == 2, "closure over a mutable array should persist across calls");

        System.out.println("ok");
    }
}
