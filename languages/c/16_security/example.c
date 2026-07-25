#include <assert.h>
#include <openssl/crypto.h>
#include <openssl/evp.h>
#include <openssl/rand.h>
#include <stdio.h>
#include <string.h>

int main(void) {
    unsigned char salt[16];
    assert(RAND_bytes(salt, sizeof(salt)) == 1);

    unsigned char hash[32];
    assert(PKCS5_PBKDF2_HMAC("hunter2", -1, salt, sizeof(salt), 200000,
                             EVP_sha256(), sizeof(hash), hash) == 1);

    // recomputing with the same salt reproduces the same hash
    unsigned char candidate[32];
    assert(PKCS5_PBKDF2_HMAC("hunter2", -1, salt, sizeof(salt), 200000,
                             EVP_sha256(), sizeof(candidate), candidate) == 1);
    assert(CRYPTO_memcmp(hash, candidate, sizeof(hash)) == 0);

    // a wrong password produces a different hash
    unsigned char wrong[32];
    assert(PKCS5_PBKDF2_HMAC("wrong", -1, salt, sizeof(salt), 200000, EVP_sha256(),
                             sizeof(wrong), wrong) == 1);
    assert(CRYPTO_memcmp(hash, wrong, sizeof(hash)) != 0);

    // the same password with a different salt hashes differently
    unsigned char other_salt[16];
    RAND_bytes(other_salt, sizeof(other_salt));
    unsigned char other_hash[32];
    PKCS5_PBKDF2_HMAC("hunter2", -1, other_salt, sizeof(other_salt), 200000,
                      EVP_sha256(), sizeof(other_hash), other_hash);
    assert(CRYPTO_memcmp(hash, other_hash, sizeof(hash)) != 0);

    printf("ok\n");
    return 0;
}
