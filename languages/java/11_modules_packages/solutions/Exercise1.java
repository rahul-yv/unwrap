import mypackage.Helpers;

public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static String exampleUsage() {
        return Helpers.greet("World");
    }

    public static void main(String[] args) {
        check(exampleUsage().equals("Hello, World!"), "exampleUsage should greet World");
        System.out.println("ok");
    }
}
