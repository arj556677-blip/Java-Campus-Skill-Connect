package com.campusskillconnect.model;

import java.sql.Timestamp;

/**
 * SkillRequest — Represents a collaboration/exchange request between students.
 *
 * Flow:
 *   1. Student A searches for a skill (e.g., "Python")
 *   2. Student A finds Student B who has that skill
 *   3. Student A sends a SkillRequest to Student B
 *   4. Student B can ACCEPT or REJECT the request
 *
 * The status field uses the RequestStatus enum:
 *   PENDING  → waiting for response
 *   ACCEPTED → collaboration agreed
 *   REJECTED → request declined
 *
 * Database table: skill_requests
 */
public class SkillRequest {

    // ── Private Fields (mapped to database columns) ─────────
    private int id;
    private int fromUserId;        // FK → users.id (who sent the request)
    private int toUserId;          // FK → users.id (who receives the request)
    private int skillId;           // FK → skills.id (which skill)
    private String message;        // Optional message from sender
    private RequestStatus status;  // PENDING / ACCEPTED / REJECTED
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // ── Display-only fields (populated by JOIN queries) ─────
    // These make it easy to show names on the requests page
    // without needing separate database queries.
    private String fromUserName;
    private String toUserName;
    private String skillName;

    // ── Constructors ────────────────────────────────────────

    /** No-argument constructor */
    public SkillRequest() {
        this.status = RequestStatus.PENDING; // Default status
    }

    /** Constructor for sending a new request */
    public SkillRequest(int fromUserId, int toUserId, int skillId, String message) {
        this.fromUserId = fromUserId;
        this.toUserId = toUserId;
        this.skillId = skillId;
        this.message = message;
        this.status = RequestStatus.PENDING;
    }

    // ── Getters and Setters ─────────────────────────────────

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFromUserId() {
        return fromUserId;
    }

    public void setFromUserId(int fromUserId) {
        this.fromUserId = fromUserId;
    }

    public int getToUserId() {
        return toUserId;
    }

    public void setToUserId(int toUserId) {
        this.toUserId = toUserId;
    }

    public int getSkillId() {
        return skillId;
    }

    public void setSkillId(int skillId) {
        this.skillId = skillId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public RequestStatus getStatus() {
        return status;
    }

    public void setStatus(RequestStatus status) {
        this.status = status;
    }

    /**
     * Convenience setter — accepts a String and converts to enum.
     * Used when reading from the database.
     */
    public void setStatusFromString(String status) {
        this.status = RequestStatus.fromString(status);
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Display-only getters/setters

    public String getFromUserName() {
        return fromUserName;
    }

    public void setFromUserName(String fromUserName) {
        this.fromUserName = fromUserName;
    }

    public String getToUserName() {
        return toUserName;
    }

    public void setToUserName(String toUserName) {
        this.toUserName = toUserName;
    }

    public String getSkillName() {
        return skillName;
    }

    public void setSkillName(String skillName) {
        this.skillName = skillName;
    }

    // ── toString() ──────────────────────────────────────────

    @Override
    public String toString() {
        return "SkillRequest{" +
                "id=" + id +
                ", fromUserId=" + fromUserId +
                ", toUserId=" + toUserId +
                ", skillId=" + skillId +
                ", status=" + status +
                '}';
    }
}
