package com.campusskillconnect.model;

/**
 * RequestStatus — Enum for collaboration request states.
 *
 * A skill request goes through these states:
 *   PENDING  → just sent, waiting for response
 *   ACCEPTED → the other student agreed to collaborate
 *   REJECTED → the other student declined
 */
public enum RequestStatus {

    PENDING("Pending"),
    ACCEPTED("Accepted"),
    REJECTED("Rejected");

    private final String label;

    RequestStatus(String label) {
        this.label = label;
    }

    /** Returns a friendly display name (e.g., "Pending") */
    public String getLabel() {
        return label;
    }

    /**
     * Converts a String (e.g., from database) to a RequestStatus enum.
     * Returns PENDING if the string doesn't match any status.
     */
    public static RequestStatus fromString(String value) {
        if (value == null) {
            return PENDING;
        }
        try {
            return RequestStatus.valueOf(value.toUpperCase());
        } catch (IllegalArgumentException e) {
            return PENDING;
        }
    }
}
