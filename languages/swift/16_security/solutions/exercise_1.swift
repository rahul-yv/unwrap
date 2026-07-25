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

func hashPassword(_ password: String, salt: [UInt8]) throws -> SymmetricKey {
    try KDF.Insecure.PBKDF2.deriveKey(
        from: Array(password.utf8),
        salt: salt,
        using: .sha256,
        outputByteCount: 32,
        unsafeUncheckedRounds: 100_000
    )
}

func verifyPassword(_ password: String, salt: [UInt8], expectedHash: SymmetricKey) throws -> Bool {
    try hashPassword(password, salt: salt) == expectedHash
}

let salt = randomBytes(16)
let hashed = try hashPassword("hunter2", salt: salt)

let correct = try verifyPassword("hunter2", salt: salt, expectedHash: hashed)
let wrong = try verifyPassword("wrong-password", salt: salt, expectedHash: hashed)
assert(correct)
assert(!wrong)

print("ok")
