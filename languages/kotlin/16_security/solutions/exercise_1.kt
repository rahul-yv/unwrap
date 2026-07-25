import java.security.MessageDigest
import java.security.SecureRandom
import javax.crypto.SecretKeyFactory
import javax.crypto.spec.PBEKeySpec

const val ITERATIONS = 100_000
const val KEY_LENGTH = 256

fun hashPassword(password: String, salt: ByteArray): ByteArray {
    val spec = PBEKeySpec(password.toCharArray(), salt, ITERATIONS, KEY_LENGTH)
    val factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256")
    return factory.generateSecret(spec).encoded
}

fun verifyPassword(password: String, salt: ByteArray, expectedHash: ByteArray): Boolean {
    val actual = hashPassword(password, salt)
    return MessageDigest.isEqual(actual, expectedHash)
}

fun main() {
    val salt = ByteArray(16).also { SecureRandom().nextBytes(it) }
    val hashed = hashPassword("hunter2", salt)

    check(verifyPassword("hunter2", salt, hashed))
    check(!verifyPassword("wrong-password", salt, hashed))

    println("ok")
}
