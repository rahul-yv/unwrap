public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static double safeDivide(double a, double b) {
        try {
            if (b == 0) {
                throw new ArithmeticException("division by zero");
            }
            return a / b;
        } catch (ArithmeticException e) {
            return Double.NaN;
        }
    }

    public static void main(String[] args) {
        check(safeDivide(10, 2) == 5.0, "safeDivide(10, 2) should be 5.0");
        check(Double.isNaN(safeDivide(10, 0)), "safeDivide(10, 0) should be NaN");
        System.out.println("ok");
    }
}
