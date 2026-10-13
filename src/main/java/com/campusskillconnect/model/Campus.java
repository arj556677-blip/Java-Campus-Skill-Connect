package com.campusskillconnect.model;

import java.sql.Timestamp;

/**
 * Campus — Represents a campus or department within an Institution.
 *
 * Each institution can have multiple campuses. For example:
 *   Institution: "NIT Calicut"
 *     → Campus: "Main Campus"
 *     → Campus: "Department of Computer Science"
 *
 * Database table: campuses
 */
public class Campus {

    // ── Private Fields ──────────────────────────────────────
    private int id;
    private int institutionId;   // Foreign key → institutions.id
    private String name;
    private String address;
    private Timestamp createdAt;

    // ── Constructors ────────────────────────────────────────

    /** No-argument constructor */
    public Campus() {
    }

    /** Parameterized constructor */
    public Campus(int id, int institutionId, String name, String address) {
        this.id = id;
        this.institutionId = institutionId;
        this.name = name;
        this.address = address;
    }

    // ── Getters and Setters ─────────────────────────────────

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getInstitutionId() {
        return institutionId;
    }

    public void setInstitutionId(int institutionId) {
        this.institutionId = institutionId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // ── toString() ──────────────────────────────────────────

    @Override
    public String toString() {
        return "Campus{" +
                "id=" + id +
                ", institutionId=" + institutionId +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}
