public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static int firstEven(int[] numbers) {
        for (int n : numbers) {
            if (n % 2 == 0) {
                return n;
            }
        }
        return -1;
    }

    public static void main(String[] args) {
        check(firstEven(new int[] {1, 3, 4, 5}) == 4, "firstEven should find 4");
        check(firstEven(new int[] {1, 3, 5}) == -1, "firstEven should return -1 when none found");
        System.out.println("ok");
    }
}
