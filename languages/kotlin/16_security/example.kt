import java.security.MessageDigest
import java.security.SecureRandom
import javax.crypto.SecretKeyFactory
import javax.crypto.spec.PBEKeySpec

const val ITERATIONS = 100_000
const val KEY_LENGTH = 256

fun hash(password: String, salt: ByteArray): ByteArray {
    val spec = PBEKeySpec(password.toCharArray(), salt, ITERATIONS, KEY_LENGTH)
    val factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256")
    return factory.generateSecret(spec).encoded
}

fun main() {
    val salt = ByteArray(16).also { SecureRandom().nextBytes(it) }
    val hashed = hash("hunter2", salt)

    val correctAttempt = hash("hunter2", salt)
    check(MessageDigest.isEqual(hashed, correctAttempt))

    val wrongAttempt = hash("wrong-password", salt)
    check(!MessageDigest.isEqual(hashed, wrongAttempt))

    println("ok")
}
