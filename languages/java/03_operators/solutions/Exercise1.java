public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static int clamp(int value, int low, int high) {
        return Math.max(low, Math.min(value, high));
    }

    public static void main(String[] args) {
        check(clamp(5, 0, 10) == 5, "clamp(5, 0, 10) should be 5");
        check(clamp(-5, 0, 10) == 0, "clamp(-5, 0, 10) should be 0");
        check(clamp(15, 0, 10) == 10, "clamp(15, 0, 10) should be 10");
        System.out.println("ok");
    }
}
