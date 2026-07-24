public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static String grade(int score) {
        Integer boxed = score;
        return switch (boxed) {
            case Integer i when i >= 90 -> "A";
            case Integer i when i >= 80 -> "B";
            case Integer i when i >= 70 -> "C";
            default -> "F";
        };
    }

    public static void main(String[] args) {
        check(grade(95).equals("A"), "grade(95) should be A");
        check(grade(72).equals("C"), "grade(72) should be C");
        check(grade(40).equals("F"), "grade(40) should be F");
        System.out.println("ok");
    }
}
