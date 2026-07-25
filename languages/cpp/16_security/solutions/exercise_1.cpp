#include <cassert>
#include <iostream>
#include <openssl/crypto.h>
#include <openssl/evp.h>
#include <openssl/rand.h>
#include <string>
#include <vector>

std::vector<unsigned char> hash_password(const std::string& password,
                                         const std::vector<unsigned char>& salt) {
    std::vector<unsigned char> hash(32);
    PKCS5_PBKDF2_HMAC(password.c_str(), -1, salt.data(), static_cast<int>(salt.size()),
                      200000, EVP_sha256(), static_cast<int>(hash.size()), hash.data());
    return hash;
}

int main() {
    std::vector<unsigned char> salt(16);
    assert(RAND_bytes(salt.data(), static_cast<int>(salt.size())) == 1);

    auto hash = hash_password("hunter2", salt);
    auto candidate = hash_password("hunter2", salt);
    assert(CRYPTO_memcmp(hash.data(), candidate.data(), hash.size()) == 0);

    auto wrong = hash_password("wrong", salt);
    assert(CRYPTO_memcmp(hash.data(), wrong.data(), hash.size()) != 0);

    std::cout << "ok\n";
    return 0;
}
