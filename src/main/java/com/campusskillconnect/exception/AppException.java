package com.campusskillconnect.exception;

/**
 * AppException — Custom exception class for Campus Skill Connect.
 *
 * WHAT IS A CUSTOM EXCEPTION?
 * ─────────────────────────────────────────────────────────────
 * Java has built-in exceptions like NullPointerException and
 * SQLException. But sometimes we want our OWN exception type
 * that is specific to our application.
 *
 * By extending Exception, we create a "checked" exception.
 * This means Java forces the calling code to handle it with
 * try-catch or declare it with "throws".
 *
 * WHY USE CUSTOM EXCEPTIONS?
 * - More meaningful error messages specific to our app
 * - Can include extra info (like an error code)
 * - Makes debugging easier
 *
 * Usage:
 *   throw new AppException("User not found with email: " + email);
 *   throw new AppException("Database error", sqlException);
 * ─────────────────────────────────────────────────────────────
 */
public class AppException extends Exception {

    // Optional error code for categorizing errors
    private String errorCode;

    /**
     * Constructor with just a message.
     * Usage: throw new AppException("Invalid email format");
     *
     * @param message description of what went wrong
     */
    public AppException(String message) {
        super(message);  // Pass the message to the parent Exception class
    }

    /**
     * Constructor with a message AND the original cause.
     * This is called "exception chaining" — we wrap the original
     * exception inside our custom one so we don't lose the
     * original stack trace.
     *
     * Usage: catch (SQLException e) {
     *            throw new AppException("DB error", e);
     *        }
     *
     * @param message description of what went wrong
     * @param cause   the original exception that caused this error
     */
    public AppException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * Constructor with message, cause, and error code.
     *
     * @param message   description of what went wrong
     * @param cause     the original exception
     * @param errorCode a short code like "DB_001" or "AUTH_FAIL"
     */
    public AppException(String message, Throwable cause, String errorCode) {
        super(message, cause);
        this.errorCode = errorCode;
    }

    /** Returns the error code, or null if not set. */
    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }
}
