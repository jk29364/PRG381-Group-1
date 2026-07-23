package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.regex.Pattern;

/**
 * Utility class for validating user input (emails, passwords, usernames)
 * and for securely hashing / verifying passwords before they are stored
 * or compared against the database.
 *
 * Passwords are never stored in plain text. Each password is hashed with
 * a random salt using SHA-256, and the salt is stored alongside the hash
 * so it can be reused when verifying a login attempt.
 */
public class ValidationUtil {

    // Basic but practical email pattern: something@something.tld
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[\\w.+-]+@[\\w-]+\\.[a-zA-Z]{2,}$");

    // At least 8 characters, 1 uppercase, 1 lowercase, 1 digit.
    private static final Pattern PASSWORD_PATTERN =
            Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$");

    // Letters, numbers, underscores only, 3-20 characters.
    private static final Pattern USERNAME_PATTERN =
            Pattern.compile("^[a-zA-Z0-9_]{3,20}$");

    private static final SecureRandom RANDOM = new SecureRandom();

    private ValidationUtil() {
        // static utility class, no instantiation
    }

    /**
     * Checks whether the given email address has a valid format.
     */
    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    /**
     * Checks whether the given password meets minimum strength requirements.
     */
    public static boolean isValidPassword(String password) {
        return password != null && PASSWORD_PATTERN.matcher(password).matches();
    }

    /**
     * Checks whether the given username has a valid format.
     */
    public static boolean isValidUsername(String username) {
        return username != null && USERNAME_PATTERN.matcher(username.trim()).matches();
    }

    /**
     * Generates a random 16-byte salt, Base64-encoded for easy storage as text.
     */
    public static String generateSalt() {
        byte[] saltBytes = new byte[16];
        RANDOM.nextBytes(saltBytes);
        return Base64.getEncoder().encodeToString(saltBytes);
    }

    /**
     * Hashes a plain-text password with the given salt using SHA-256.
     * The same salt + password combination always produces the same hash,
     * which is what allows us to verify logins later.
     *
     * @param password plain-text password entered by the user
     * @param salt     Base64-encoded salt (generate one per user at registration time)
     * @return Base64-encoded hash string, safe to store in the database
     */
    public static String hashPassword(String password, String salt) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            digest.update(Base64.getDecoder().decode(salt));
            byte[] hashedBytes = digest.digest(password.getBytes("UTF-8"));
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (NoSuchAlgorithmException | java.io.UnsupportedEncodingException e) {
            // SHA-256 and UTF-8 are always available on standard JVMs, so this
            // should never happen in practice, but we wrap it just in case.
            throw new RuntimeException("Error hashing password", e);
        }
    }

    /**
     * Verifies a plain-text password against a previously stored hash + salt.
     *
     * @param password       plain-text password entered at login
     * @param storedHash     hash retrieved from the database
     * @param storedSalt     salt retrieved from the database
     * @return true if the password matches, false otherwise
     */
    public static boolean verifyPassword(String password, String storedHash, String storedSalt) {
        String computedHash = hashPassword(password, storedSalt);
        return computedHash.equals(storedHash);
    }
}
