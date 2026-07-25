require "openssl"
require "securerandom"

ITERATIONS = 100_000
KEY_LENGTH = 32

def hash(password, salt)
  OpenSSL::PKCS5.pbkdf2_hmac(password, salt, ITERATIONS, KEY_LENGTH, "sha256")
end

salt = SecureRandom.random_bytes(16)
hashed = hash("hunter2", salt)

correct_attempt = hash("hunter2", salt)
raise "fail" unless OpenSSL.fixed_length_secure_compare(hashed, correct_attempt)

wrong_attempt = hash("wrong-password", salt)
raise "fail" if OpenSSL.fixed_length_secure_compare(hashed, wrong_attempt)

puts "ok"
