#include <cassert>
#include <iostream>
#include <openssl/crypto.h>
#include <openssl/evp.h>
#include <openssl/rand.h>
#include <string>
#include <vector>

std::vector<unsigned char> pbkdf2(const std::string& password,
                                  const std::vector<unsigned char>& salt) {
    std::vector<unsigned char> hash(32);
    int ok = PKCS5_PBKDF2_HMAC(password.c_str(), -1, salt.data(),
                               static_cast<int>(salt.size()), 200000, EVP_sha256(),
                               static_cast<int>(hash.size()), hash.data());
    assert(ok == 1);
    return hash;
}

int main() {
    std::vector<unsigned char> salt(16);
    assert(RAND_bytes(salt.data(), static_cast<int>(salt.size())) == 1);

    auto hash = pbkdf2("hunter2", salt);
    auto candidate = pbkdf2("hunter2", salt);
    assert(CRYPTO_memcmp(hash.data(), candidate.data(), hash.size()) == 0);

    auto wrong = pbkdf2("wrong", salt);
    assert(CRYPTO_memcmp(hash.data(), wrong.data(), hash.size()) != 0);

    // same password, different salt -> different hash
    std::vector<unsigned char> other_salt(16);
    RAND_bytes(other_salt.data(), static_cast<int>(other_salt.size()));
    auto other_hash = pbkdf2("hunter2", other_salt);
    assert(CRYPTO_memcmp(hash.data(), other_hash.data(), hash.size()) != 0);

    std::cout << "ok\n";
    return 0;
}
