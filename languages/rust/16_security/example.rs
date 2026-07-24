use argon2::password_hash::{rand_core::OsRng, PasswordHasher, SaltString};
use argon2::{Argon2, PasswordHash, PasswordVerifier};

fn main() {
    let salt = SaltString::generate(&mut OsRng);
    let argon2 = Argon2::default();
    let hash = argon2
        .hash_password(b"hunter2", &salt)
        .unwrap()
        .to_string();

    let parsed_hash = PasswordHash::new(&hash).unwrap();
    assert!(argon2.verify_password(b"hunter2", &parsed_hash).is_ok());
    assert!(argon2.verify_password(b"wrong", &parsed_hash).is_err());

    // same password hashed twice produces different hashes, since a fresh
    // random salt is generated each time
    let other_salt = SaltString::generate(&mut OsRng);
    let other_hash = argon2
        .hash_password(b"hunter2", &other_salt)
        .unwrap()
        .to_string();
    assert_ne!(hash, other_hash);

    println!("ok");
}
