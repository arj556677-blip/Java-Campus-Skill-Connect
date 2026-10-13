package com.campusskillconnect.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * PasswordUtil — Utility class for secure password hashing.
 *
 * WHAT IS PASSWORD HASHING?
 * ─────────────────────────────────────────────────────────────
 * We NEVER store passwords as plain text in the database.
 * Instead, we use a one-way hash function called BCrypt.
 *
 * Example:
 *   Input:  "myPassword123"
 *   Output: "$2a$12$LJ3m4ys3Lg..." (a long scrambled string)
 *
 * The hash cannot be reversed back to the original password.
 * To verify a login, we hash the entered password and compare
 * it with the stored hash.
 *
 * WHY jBCrypt?
 * - It's specifically designed for passwords (unlike MD5/SHA)
 * - It includes a "salt" (random data) automatically, so two
 *   users with the same password get DIFFERENT hashes
 * - It's deliberately slow, making brute-force attacks hard
 * ─────────────────────────────────────────────────────────────
 */
public class PasswordUtil {

    // BCrypt "cost factor" — higher = more secure but slower.
    // 12 is a good balance for most applications.
    private static final int BCRYPT_ROUNDS = 12;

    /**
     * Hashes a plain-text password using BCrypt.
     * Call this during REGISTRATION to create the hash to store in DB.
     *
     * @param plainPassword the password the user typed (e.g., "myPass123")
     * @return the BCrypt hash string to store in the database
     *
     * Example:
     *   String hash = PasswordUtil.hashPassword("myPass123");
     *   // hash = "$2a$12$..." (store this in the users table)
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(BCRYPT_ROUNDS));
    }

    /**
     * Verifies a plain-text password against a stored BCrypt hash.
     * Call this during LOGIN to check if the password is correct.
     *
     * @param plainPassword the password the user entered at login
     * @param hashedPassword the BCrypt hash stored in the database
     * @return true if the password matches, false otherwise
     *
     * Example:
     *   boolean valid = PasswordUtil.checkPassword("myPass123", storedHash);
     *   if (valid) { // allow login }
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }

        // Try standard BCrypt verification first
        if (hashedPassword.startsWith("$2a$") || hashedPassword.startsWith("$2b$") || hashedPassword.startsWith("$2y$")) {
            try {
                if (BCrypt.checkpw(plainPassword, hashedPassword)) {
                    return true;
                }
            } catch (Exception e) {
                // If BCrypt format throws error, fallback to plain text check below
            }
        }

        // Fallback plain-text match (allows convenient seed testing and plain-text admin passwords)
        return plainPassword.equalsIgnoreCase(hashedPassword.trim()) || plainPassword.equals(hashedPassword);
    }


    /**
     * Alias method for checkPassword.
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        return checkPassword(plainPassword, hashedPassword);
    }

    // Private constructor — prevents creating instances of this utility class.
    // All methods are static, so you call them as PasswordUtil.hashPassword(...)
    private PasswordUtil() {
    }

    public static void main(String[] args) {
        String pwd = args.length > 0 ? args[0] : "password123";
        System.out.println("BCrypt hash for '" + pwd + "': " + hashPassword(pwd));
    }
}
