import java.util.HashSet;
import java.util.Set;

public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    interface Speaker {
        String speak();
    }

    static abstract class Animal implements Speaker {
        protected final String name;

        Animal(String name) {
            this.name = name;
        }
    }

    static class Dog extends Animal {
        Dog(String name) {
            super(name);
        }

        public String speak() {
            return name + " says Woof";
        }
    }

    record Point(int x, int y) {}

    static class PlainPoint {
        int x, y;

        PlainPoint(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }

    public static void main(String[] args) {
        Dog dog = new Dog("Rex");
        check(dog.speak().equals("Rex says Woof"), "Dog should implement Speaker");
        check(dog instanceof Animal && dog instanceof Speaker, "Dog should be both an Animal and a Speaker");

        Point p1 = new Point(3, 4);
        Point p2 = new Point(3, 4);
        check(p1.equals(p2), "records should compare by field value");
        check(p1.hashCode() == p2.hashCode(), "equal records should have equal hash codes");
        check(p1.x() == 3 && p1.y() == 4, "record accessors should return field values");

        PlainPoint pp1 = new PlainPoint(3, 4);
        PlainPoint pp2 = new PlainPoint(3, 4);
        check(!pp1.equals(pp2), "a plain class without overridden equals() compares by identity");

        Set<Point> points = new HashSet<>();
        points.add(new Point(1, 1));
        points.add(new Point(1, 1)); // same value, should not add a duplicate
        check(points.size() == 1, "HashSet should deduplicate records by value");

        System.out.println("ok");
    }
}
