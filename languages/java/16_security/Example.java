import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.MessageDigest;
import java.security.SecureRandom;

public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static byte[] pbkdf2(String password, byte[] salt) throws Exception {
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 200_000, 256);
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        return factory.generateSecret(spec).getEncoded();
    }

    public static void main(String[] args) throws Exception {
        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);

        byte[] hash = pbkdf2("hunter2", salt);
        byte[] candidate = pbkdf2("hunter2", salt);
        check(MessageDigest.isEqual(hash, candidate), "same password and salt should produce a matching hash");

        byte[] wrongHash = pbkdf2("wrong password", salt);
        check(!MessageDigest.isEqual(hash, wrongHash), "wrong password should not match");

        byte[] otherSalt = new byte[16];
        new SecureRandom().nextBytes(otherSalt);
        byte[] otherHash = pbkdf2("hunter2", otherSalt);
        check(!MessageDigest.isEqual(hash, otherHash), "same password with a different salt should hash differently");

        System.out.println("ok");
    }
}
