public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static int sumConcurrently(int[] numbers) throws InterruptedException {
        int mid = numbers.length / 2;
        int[] results = new int[2];

        Thread first = new Thread(() -> {
            int total = 0;
            for (int i = 0; i < mid; i++) {
                total += numbers[i];
            }
            results[0] = total;
        });

        Thread second = new Thread(() -> {
            int total = 0;
            for (int i = mid; i < numbers.length; i++) {
                total += numbers[i];
            }
            results[1] = total;
        });

        first.start();
        second.start();
        first.join();
        second.join();

        return results[0] + results[1];
    }

    public static void main(String[] args) throws InterruptedException {
        check(sumConcurrently(new int[] {1, 2, 3, 4}) == 10, "sumConcurrently should sum to 10");
        check(sumConcurrently(new int[] {}) == 0, "sumConcurrently of empty array should be 0");
        System.out.println("ok");
    }
}
