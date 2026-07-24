import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ExampleTest {
    @Test
    void addsPositiveNumbers() {
        assertEquals(5, Example.add(2, 3));
    }

    @Test
    void addsNegativeNumbers() {
        assertEquals(-5, Example.add(-2, -3));
    }

    @Test
    void addsZero() {
        assertEquals(0, Example.add(0, 0));
    }
}
