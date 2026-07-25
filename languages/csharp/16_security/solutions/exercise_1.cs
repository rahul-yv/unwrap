using System.Diagnostics;
using System.Security.Cryptography;

const int iterations = 100_000;
const int hashSize = 32;

byte[] HashPassword(string password, byte[] salt) =>
	Rfc2898DeriveBytes.Pbkdf2(password, salt, iterations, HashAlgorithmName.SHA256, hashSize);

bool VerifyPassword(string password, byte[] salt, byte[] expectedHash)
{
	byte[] actual = HashPassword(password, salt);
	return CryptographicOperations.FixedTimeEquals(actual, expectedHash);
}

byte[] salt = RandomNumberGenerator.GetBytes(16);
byte[] hash = HashPassword("hunter2", salt);

Debug.Assert(VerifyPassword("hunter2", salt, hash));
Debug.Assert(!VerifyPassword("wrong-password", salt, hash));

Console.WriteLine("ok");
