using System.Diagnostics;
using System.Security.Cryptography;

const int iterations = 100_000;
const int saltSize = 16;
const int hashSize = 32;

byte[] Hash(string password, byte[] salt) =>
	Rfc2898DeriveBytes.Pbkdf2(password, salt, iterations, HashAlgorithmName.SHA256, hashSize);

byte[] salt = RandomNumberGenerator.GetBytes(saltSize);
byte[] hash = Hash("hunter2", salt);

byte[] correctAttempt = Hash("hunter2", salt);
Debug.Assert(CryptographicOperations.FixedTimeEquals(hash, correctAttempt));

byte[] wrongAttempt = Hash("wrong-password", salt);
Debug.Assert(!CryptographicOperations.FixedTimeEquals(hash, wrongAttempt));

Console.WriteLine("ok");
