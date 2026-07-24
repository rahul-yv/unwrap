import hashlib
import hmac
import secrets

ITERATIONS = 200_000


def hash_password(password):
    salt = secrets.token_bytes(16)
    digest = hashlib.pbkdf2_hmac("sha256", password.encode(), salt, ITERATIONS)
    return salt, digest


def verify_password(password, salt, digest):
    candidate = hashlib.pbkdf2_hmac("sha256", password.encode(), salt, ITERATIONS)
    return hmac.compare_digest(candidate, digest)


if __name__ == "__main__":
    salt, digest = hash_password("hunter2")
    assert verify_password("hunter2", salt, digest)
    assert not verify_password("wrong", salt, digest)
    print("ok")
