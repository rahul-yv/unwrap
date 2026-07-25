#include <assert.h>
#include <openssl/crypto.h>
#include <openssl/evp.h>
#include <openssl/rand.h>
#include <stdio.h>

int hash_password(const char *password, const unsigned char *salt, int salt_len,
                  unsigned char *out, int out_len) {
    return PKCS5_PBKDF2_HMAC(password, -1, salt, salt_len, 200000, EVP_sha256(),
                             out_len, out);
}

int main(void) {
    unsigned char salt[16];
    assert(RAND_bytes(salt, sizeof(salt)) == 1);

    unsigned char hash[32];
    assert(hash_password("hunter2", salt, sizeof(salt), hash, sizeof(hash)) == 1);

    // verifying: recompute with the same salt, compare in constant time
    unsigned char candidate[32];
    hash_password("hunter2", salt, sizeof(salt), candidate, sizeof(candidate));
    assert(CRYPTO_memcmp(hash, candidate, sizeof(hash)) == 0);

    unsigned char wrong[32];
    hash_password("wrong", salt, sizeof(salt), wrong, sizeof(wrong));
    assert(CRYPTO_memcmp(hash, wrong, sizeof(hash)) != 0);

    printf("ok\n");
    return 0;
}
