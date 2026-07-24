import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class Exercise1Test {
    static int add(int a, int b) {
        return a + b;
    }

    @Test
    void addsZero() {
        assertEquals(0, add(0, 0));
    }

    @Test
    void addsCancellingValues() {
        assertEquals(0, add(-1, 1));
    }
}
