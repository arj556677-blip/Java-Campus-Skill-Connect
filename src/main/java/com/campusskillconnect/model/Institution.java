package com.campusskillconnect.model;

import java.sql.Timestamp;

/**
 * Institution — Represents a college or university in the system.
 *
 * OOP CONCEPTS DEMONSTRATED:
 * ─────────────────────────────────────────────────────────────
 * 1. ENCAPSULATION:
 *    All fields are "private" — they cannot be accessed directly
 *    from outside this class. Instead, we provide public getter
 *    and setter methods to read/write the values safely.
 *
 * 2. CONSTRUCTORS:
 *    - No-arg constructor: new Institution()
 *    - Parameterized constructor: new Institution(id, name, city, state)
 *
 * 3. METHODS:
 *    - Getters/Setters for each field
 *    - toString() for a readable representation
 * ─────────────────────────────────────────────────────────────
 *
 * Database table: institutions
 */
public class Institution {

    // ── Private Fields (Encapsulation) ──────────────────────
    private int id;
    private String name;
    private String city;
    private String state;
    private Timestamp createdAt;

    // ── Constructors ────────────────────────────────────────

    /**
     * No-argument constructor.
     * Required by frameworks (like JSP) that create objects
     * first and then set values using setters.
     */
    public Institution() {
    }

    /**
     * Parameterized constructor — creates an Institution with values.
     *
     * @param id    the unique database ID
     * @param name  the institution name (e.g., "NIT Calicut")
     * @param city  the city where the institution is located
     * @param state the state
     */
    public Institution(int id, String name, String city, String state) {
        this.id = id;       // "this.id" = the field, "id" = the parameter
        this.name = name;
        this.city = city;
        this.state = state;
    }

    // ── Getters and Setters ─────────────────────────────────

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // ── toString() ──────────────────────────────────────────

    /**
     * Returns a human-readable string representation.
     * Useful for debugging: System.out.println(institution);
     */
    @Override
    public String toString() {
        return "Institution{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", city='" + city + '\'' +
                ", state='" + state + '\'' +
                '}';
    }
}
