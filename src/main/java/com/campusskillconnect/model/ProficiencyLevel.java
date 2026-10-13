package com.campusskillconnect.model;

/**
 * ProficiencyLevel — Enum representing how skilled a student is.
 *
 * WHAT IS AN ENUM?
 * An enum (short for "enumeration") is a special Java type that
 * defines a fixed set of constants. Instead of using Strings like
 * "BEGINNER" which could be misspelled, enums guarantee only
 * valid values can be used.
 *
 * Usage example:
 *   ProficiencyLevel level = ProficiencyLevel.INTERMEDIATE;
 *   System.out.println(level);            // prints "INTERMEDIATE"
 *   System.out.println(level.getLabel()); // prints "Intermediate"
 */
public enum ProficiencyLevel {

    BEGINNER("Beginner"),
    INTERMEDIATE("Intermediate"),
    ADVANCED("Advanced");

    // Each enum constant has a human-readable label
    private final String label;

    // Enum constructor (always private — you can't create new instances)
    ProficiencyLevel(String label) {
        this.label = label;
    }

    /**
     * Returns a friendly display name for the proficiency level.
     * Example: ProficiencyLevel.BEGINNER.getLabel() → "Beginner"
     */
    public String getLabel() {
        return label;
    }

    /**
     * Converts a String (e.g., from database) to a ProficiencyLevel enum.
     * Returns BEGINNER if the string doesn't match any level.
     *
     * @param value the string to convert (e.g., "INTERMEDIATE")
     * @return the matching ProficiencyLevel
     */
    public static ProficiencyLevel fromString(String value) {
        if (value == null) {
            return BEGINNER;
        }
        try {
            return ProficiencyLevel.valueOf(value.toUpperCase());
        } catch (IllegalArgumentException e) {
            // If the string doesn't match any enum constant, default to BEGINNER
            return BEGINNER;
        }
    }
}
