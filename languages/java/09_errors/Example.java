public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static class InsufficientFundsException extends Exception {
        InsufficientFundsException(String message) {
            super(message);
        }
    }

    static void withdraw(double balance, double amount) throws InsufficientFundsException {
        if (amount > balance) {
            throw new InsufficientFundsException("insufficient funds");
        }
    }

    static class Resource implements AutoCloseable {
        boolean closed = false;

        @Override
        public void close() {
            closed = true;
        }
    }

    public static void main(String[] args) throws Exception {
        boolean caught = false;
        try {
            withdraw(10, 50);
        } catch (InsufficientFundsException e) {
            caught = true;
            check(e.getMessage().equals("insufficient funds"), "message should match");
        }
        check(caught, "checked exception should be catchable");

        boolean finallyRan = false;
        try {
            withdraw(10, 50);
        } catch (InsufficientFundsException e) {
            // handled
        } finally {
            finallyRan = true;
        }
        check(finallyRan, "finally should always run");

        Resource resource;
        try (Resource r = new Resource()) {
            resource = r;
            check(!r.closed, "resource should not be closed yet inside the try block");
        }
        check(resource.closed, "try-with-resources should close automatically on exit");

        // integer division by zero throws; floating-point division by zero does not
        boolean intThrew = false;
        try {
            int x = 5 / 0;
        } catch (ArithmeticException e) {
            intThrew = true;
        }
        check(intThrew, "integer division by zero should throw ArithmeticException");

        double result = 5.0 / 0;
        check(Double.isInfinite(result), "floating-point division by zero should produce infinity, not throw");

        System.out.println("ok");
    }
}
