# Exercises: Security Basics

1. Write `def hash_password(password, salt)` using `OpenSSL::PKCS5.pbkdf2_hmac`, and `def verify_password(password, salt, expected_hash)` that re-hashes and compares with `OpenSSL.fixed_length_secure_compare`.

Check your answer against [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).
