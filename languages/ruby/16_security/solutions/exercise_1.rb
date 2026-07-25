require "openssl"
require "securerandom"

ITERATIONS = 100_000
KEY_LENGTH = 32

def hash_password(password, salt)
  OpenSSL::PKCS5.pbkdf2_hmac(password, salt, ITERATIONS, KEY_LENGTH, "sha256")
end

def verify_password(password, salt, expected_hash)
  actual = hash_password(password, salt)
  OpenSSL.fixed_length_secure_compare(actual, expected_hash)
end

salt = SecureRandom.random_bytes(16)
hashed = hash_password("hunter2", salt)

raise "fail" unless verify_password("hunter2", salt, hashed)
raise "fail" if verify_password("wrong-password", salt, hashed)

puts "ok"
