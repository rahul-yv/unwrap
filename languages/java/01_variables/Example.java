import java.util.ArrayList;
import java.util.List;

public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    public static void main(String[] args) {
        int age = 25;
        var name = "Ada";
        age = age + 1;
        check(age == 26, "age should be 26");
        check(name.equals("Ada"), "name should be Ada");

        final int maxRetries = 3;
        check(maxRetries == 3, "maxRetries should be 3");

        int[] point = {3, 4};
        check(point[0] == 3 && point[1] == 4, "point should hold {3, 4}");

        final List<Integer> list = new ArrayList<>();
        list.add(1); // allowed: final protects the binding, not the object's contents
        check(list.size() == 1, "final list should still be mutable");

        int primitive = 5;
        Integer boxed = 5;
        Integer boxedOther = 5;
        check(primitive == boxed, "primitive == boxed compares by value via unboxing");
        check(boxedOther.equals(boxed), "use equals() to compare boxed types by value");

        System.out.println("ok");
    }
}
