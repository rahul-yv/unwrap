import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.MessageDigest;
import java.security.SecureRandom;

public class Exercise1 {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static byte[] hashPassword(String password, byte[] salt) throws Exception {
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 200_000, 256);
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        return factory.generateSecret(spec).getEncoded();
    }

    static boolean verifyPassword(String password, byte[] salt, byte[] expectedHash) throws Exception {
        return MessageDigest.isEqual(hashPassword(password, salt), expectedHash);
    }

    public static void main(String[] args) throws Exception {
        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);
        byte[] hash = hashPassword("hunter2", salt);

        check(verifyPassword("hunter2", salt, hash), "correct password should verify");
        check(!verifyPassword("wrong", salt, hash), "wrong password should not verify");

        System.out.println("ok");
    }
}
