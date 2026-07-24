public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    public static void main(String[] args) {
        int q = 7 / 2;
        int r = 7 % 2;
        double half = 7.0 / 2;
        check(q == 3, "7/2 should truncate to 3");
        check(r == 1, "7%2 should be 1");
        check(half == 3.5, "7.0/2 should be 3.5");

        String label = q > 0 ? "pass" : "fail";
        check(label.equals("pass"), "ternary should evaluate the true branch");

        Object value = "hello";
        boolean matched = false;
        if (value instanceof String s) {
            matched = s.length() == 5;
        }
        check(matched, "pattern-matching instanceof should bind and check the cast value");

        boolean[] called = {false};
        boolean result = true || setTrueAndReturn(called);
        check(result && !called[0], "|| should short-circuit and skip the second operand");

        System.out.println("ok");
    }

    static boolean setTrueAndReturn(boolean[] flag) {
        flag[0] = true;
        return true;
    }
}
