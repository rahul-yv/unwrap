# Exercises: Security Basics

1. Write `std::vector<unsigned char> hash_password(const std::string& password, const std::vector<unsigned char>& salt)` returning a 32-byte PBKDF2-HMAC-SHA256 hash (200,000 iterations).

Compile with `c++ solutions/exercise_1.cpp -o exercise_1 -lcrypto`.

Check your answer against [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).
