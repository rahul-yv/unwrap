import _CryptoExtras
import Crypto
import Foundation

func randomBytes(_ count: Int) -> [UInt8] {
    var bytes = [UInt8](repeating: 0, count: count)
    let fd = open("/dev/urandom", O_RDONLY)
    _ = read(fd, &bytes, count)
    close(fd)
    return bytes
}

func hash(_ password: String, salt: [UInt8]) throws -> SymmetricKey {
    try KDF.Insecure.PBKDF2.deriveKey(
        from: Array(password.utf8),
        salt: salt,
        using: .sha256,
        outputByteCount: 32,
        unsafeUncheckedRounds: 100_000
    )
}

let salt = randomBytes(16)
let hashed = try hash("hunter2", salt: salt)
let attempt = try hash("hunter2", salt: salt)
assert(hashed == attempt)

let wrongAttempt = try hash("wrong-password", salt: salt)
assert(hashed != wrongAttempt)

print("ok")
