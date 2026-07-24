public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static boolean sameContent(String a, String b) {
        if (a == null || b == null) {
            return false;
        }
        return a.equals(b);
    }

    public static void main(String[] args) {
        check(sameContent("hi", "hi"), "identical literals should match");
        check(sameContent("hi", new String("hi")), "equal content should match regardless of identity");
        check(!sameContent(null, "hi"), "null should not throw and should return false");
        check(!sameContent("hi", null), "null should not throw and should return false");
        System.out.println("ok");
    }
}
