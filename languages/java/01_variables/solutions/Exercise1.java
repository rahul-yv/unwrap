public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static int[] swap(int a, int b) {
        return new int[] {b, a};
    }

    public static void main(String[] args) {
        int[] result = swap(1, 2);
        check(result[0] == 2 && result[1] == 1, "swap(1, 2) should be {2, 1}");
        System.out.println("ok");
    }
}
