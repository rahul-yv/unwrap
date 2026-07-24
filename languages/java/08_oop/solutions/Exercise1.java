public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    record Rectangle(double width, double height) {
        double area() {
            return width * height;
        }
    }

    public static void main(String[] args) {
        check(new Rectangle(3, 4).area() == 12.0, "area should be 12.0");
        check(new Rectangle(3, 4).equals(new Rectangle(3, 4)), "equal records should be equals()");
        check(!new Rectangle(3, 4).equals(new Rectangle(4, 3)), "different dimensions should not be equal");
        System.out.println("ok");
    }
}
