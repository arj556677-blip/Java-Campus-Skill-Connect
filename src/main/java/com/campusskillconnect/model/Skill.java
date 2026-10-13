package com.campusskillconnect.model;

import java.sql.Timestamp;

/**
 * Skill — Represents a skill that a student has listed on their profile.
 *
 * Each student can have multiple skills. For example:
 *   User: "Rahul"
 *     → Skill: "Java Programming" (INTERMEDIATE)
 *     → Skill: "Web Design" (BEGINNER)
 *     → Skill: "Data Analysis with Python" (ADVANCED)
 *
 * The proficiency level uses the ProficiencyLevel enum.
 *
 * Database table: skills
 */
public class Skill {

    // ── Private Fields ──────────────────────────────────────
    private int id;
    private int userId;                     // FK → users.id
    private String skillName;               // e.g., "Java Programming"
    private ProficiencyLevel proficiencyLevel;  // BEGINNER / INTERMEDIATE / ADVANCED
    private String description;             // Optional details about the skill
    private Timestamp createdAt;

    // ── Display-only field (for search results) ─────────────
    private String userName;  // Populated by JOIN queries

    // ── Constructors ────────────────────────────────────────

    /** No-argument constructor */
    public Skill() {
        this.proficiencyLevel = ProficiencyLevel.BEGINNER; // Default
    }

    /** Parameterized constructor for adding a new skill */
    public Skill(int userId, String skillName, ProficiencyLevel proficiencyLevel,
                 String description) {
        this.userId = userId;
        this.skillName = skillName;
        this.proficiencyLevel = proficiencyLevel;
        this.description = description;
    }

    // ── Getters and Setters ─────────────────────────────────

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getSkillName() {
        return skillName;
    }

    public void setSkillName(String skillName) {
        this.skillName = skillName;
    }

    public ProficiencyLevel getProficiencyLevel() {
        return proficiencyLevel;
    }

    public void setProficiencyLevel(ProficiencyLevel proficiencyLevel) {
        this.proficiencyLevel = proficiencyLevel;
    }

    /**
     * Convenience setter — accepts a String and converts it to enum.
     * Useful when reading from database or form input.
     */
    public void setProficiencyLevelFromString(String level) {
        this.proficiencyLevel = ProficiencyLevel.fromString(level);
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    // ── toString() ──────────────────────────────────────────

    @Override
    public String toString() {
        return "Skill{" +
                "id=" + id +
                ", skillName='" + skillName + '\'' +
                ", proficiencyLevel=" + proficiencyLevel +
                ", userId=" + userId +
                '}';
    }
}
