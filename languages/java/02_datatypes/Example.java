public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    public static void main(String[] args) {
        int n = 10;
        long big = 10_000_000_000L;
        double pi = 3.14159;
        char c = 'A';
        boolean ok = true;
        check(n == 10 && big == 10_000_000_000L && c == 'A' && ok, "primitives should hold their values");
        check(Math.abs(pi - 3.14159) < 1e-9, "pi should be approximately 3.14159");

        String s = "hello";
        String upper = s.toUpperCase();
        check(s.equals("hello"), "toUpperCase should not mutate the original string");
        check(upper.equals("HELLO"), "toUpperCase should return the uppercased string");

        check(s == "hello", "string literals should be interned");
        check(new String("hello") != "hello", "a runtime-constructed string is a distinct object");
        check(new String("hello").equals("hello"), "equals() compares content regardless of identity");

        int truncated = (int) 3.99;
        check(truncated == 3, "narrowing cast should truncate toward zero");

        check(0.1 + 0.2 != 0.3, "float math is not bit-exact, same as other languages");

        System.out.println("ok");
    }
}
