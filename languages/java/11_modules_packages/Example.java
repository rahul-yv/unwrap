import mypackage.Helpers;

public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    public static void main(String[] args) {
        check(Helpers.greet("Ada").equals("Hello, Ada!"), "Helpers.greet should return a greeting");
        System.out.println("ok");
    }
}
