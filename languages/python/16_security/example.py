import hashlib
import hmac
import secrets


def demo():
    salt = secrets.token_bytes(16)
    password = "correct horse battery staple"

    digest = hashlib.pbkdf2_hmac("sha256", password.encode(), salt, 200_000)
    candidate_digest = hashlib.pbkdf2_hmac("sha256", password.encode(), salt, 200_000)
    assert hmac.compare_digest(digest, candidate_digest)

    wrong_digest = hashlib.pbkdf2_hmac("sha256", b"wrong password", salt, 200_000)
    assert not hmac.compare_digest(digest, wrong_digest)

    # same password, different salt -> different digest (defeats rainbow tables)
    other_salt = secrets.token_bytes(16)
    other_digest = hashlib.pbkdf2_hmac("sha256", password.encode(), other_salt, 200_000)
    assert other_digest != digest

    token = secrets.token_hex(16)
    assert len(token) == 32  # 16 bytes as hex


if __name__ == "__main__":
    demo()
    print("ok")
