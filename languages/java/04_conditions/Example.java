public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    public static void main(String[] args) {
        int score = 85;
        String grade;
        if (score >= 90) {
            grade = "A";
        } else if (score >= 80) {
            grade = "B";
        } else {
            grade = "C";
        }
        check(grade.equals("B"), "score 85 should be grade B");

        Integer boxedScore = score;
        String grade2 = switch (boxedScore) {
            case Integer i when i >= 90 -> "A";
            case Integer i when i >= 80 -> "B";
            default -> "C";
        };
        check(grade2.equals("B"), "switch expression should match if/else result");

        int fallCount = fallthroughDemo(1);
        check(fallCount == 2, "classic switch without break should fall through");

        int noFallCount = noFallthroughDemo(1);
        check(noFallCount == 1, "switch expression never falls through");

        System.out.println("ok");
    }

    static int fallthroughDemo(int n) {
        int hits = 0;
        switch (n) {
            case 1:
                hits++;
                // intentional fallthrough
            case 2:
                hits++;
                break;
            case 3:
                hits++;
                break;
        }
        return hits;
    }

    static int noFallthroughDemo(int n) {
        return switch (n) {
            case 1 -> 1;
            case 2 -> 2;
            default -> 0;
        };
    }
}
