<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="My Skills — Campus SkillConnect" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-4">

    <!-- Page Header -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-lightbulb me-2" style="color:#7f5af0;"></i>My Skills Portfolio</h3>
            <p class="text-muted mb-0">Add, update, or remove the skills you want to share with peers.</p>
        </div>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-custom btn-sm">
            <i class="fa-solid fa-arrow-left me-1"></i> Dashboard
        </a>
    </div>

    <!-- Success / Error Alerts -->
    <c:if test="${param.success eq 'added'}">
        <div class="alert alert-custom-success d-flex align-items-center gap-2 mb-4">
            <i class="fa-solid fa-circle-check fs-5"></i><div>Skill added successfully!</div>
        </div>
    </c:if>
    <c:if test="${param.success eq 'updated'}">
        <div class="alert alert-custom-success d-flex align-items-center gap-2 mb-4">
            <i class="fa-solid fa-circle-check fs-5"></i><div>Skill updated successfully!</div>
        </div>
    </c:if>
    <c:if test="${param.success eq 'deleted'}">
        <div class="alert alert-custom-success d-flex align-items-center gap-2 mb-4">
            <i class="fa-solid fa-circle-check fs-5"></i><div>Skill deleted.</div>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-custom-danger d-flex align-items-center gap-2 mb-4">
            <i class="fa-solid fa-circle-exclamation fs-5"></i><div><c:out value="${errorMessage}" /></div>
        </div>
    </c:if>

    <div class="row g-4">

        <!-- Add / Edit Form -->
        <div class="col-lg-4">
            <div class="glass-card sticky-top" style="top: 90px;">
                <h5 class="fw-bold mb-3">
                    <c:choose>
                        <c:when test="${not empty editSkill}">
                            <i class="fa-solid fa-pen me-2" style="color:#2cb67d;"></i>Edit Skill
                        </c:when>
                        <c:otherwise>
                            <i class="fa-solid fa-plus me-2" style="color:#2cb67d;"></i>Add New Skill
                        </c:otherwise>
                    </c:choose>
                </h5>

                <form action="${pageContext.request.contextPath}/skills" method="POST" id="skillForm">
                    <c:choose>
                        <c:when test="${not empty editSkill}">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="skillId" value="${editSkill.id}">
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="action" value="add">
                        </c:otherwise>
                    </c:choose>

                    <div class="mb-3">
                        <label for="skillName" class="form-label">Skill Name *</label>
                        <input type="text" class="form-control" id="skillName" name="skillName"
                               placeholder="e.g. Java Programming, Python, UI Design"
                               value="<c:out value='${editSkill.skillName}' />" required>
                    </div>

                    <div class="mb-3">
                        <label for="proficiencyLevel" class="form-label">Proficiency Level *</label>
                        <select class="form-select" id="proficiencyLevel" name="proficiencyLevel" required>
                            <c:forEach items="${proficiencyLevels}" var="level">
                                <option value="${level}"
                                    ${editSkill.proficiencyLevel eq level ? 'selected' : ''}>
                                    <c:out value="${level}" />
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label for="description" class="form-label">Description <span class="text-muted">(optional)</span></label>
                        <textarea class="form-control" id="description" name="description" rows="3"
                                  placeholder="Briefly describe your experience with this skill..."><c:out value='${editSkill.description}' /></textarea>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary-custom">
                            <c:choose>
                                <c:when test="${not empty editSkill}">
                                    <i class="fa-solid fa-floppy-disk me-1"></i> Save Changes
                                </c:when>
                                <c:otherwise>
                                    <i class="fa-solid fa-plus me-1"></i> Add Skill
                                </c:otherwise>
                            </c:choose>
                        </button>
                        <c:if test="${not empty editSkill}">
                            <a href="${pageContext.request.contextPath}/skills" class="btn btn-outline-secondary">Cancel</a>
                        </c:if>
                    </div>
                </form>
            </div>
        </div>

        <!-- Skills List -->
        <div class="col-lg-8">
            <div class="glass-card">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h5 class="fw-bold mb-0">Listed Skills
                        <span class="badge badge-custom-purple ms-2">${userSkills.size()}</span>
                    </h5>
                </div>

                <c:choose>
                    <c:when test="${not empty userSkills}">
                        <div class="row g-3">
                            <c:forEach items="${userSkills}" var="skill">
                                <div class="col-md-6">
                                    <div class="p-3 rounded-3 h-100 position-relative"
                                         style="background: rgba(15,20,32,0.6); border: 1px solid rgba(255,255,255,0.08);">
                                        <div class="d-flex align-items-start justify-content-between mb-2">
                                            <h6 class="fw-bold text-white mb-0 me-2">
                                                <c:out value="${skill.skillName}" />
                                            </h6>
                                            <span class="badge flex-shrink-0 ${skill.proficiencyLevel.name() eq 'BEGINNER' ? 'badge-custom-purple' : (skill.proficiencyLevel.name() eq 'INTERMEDIATE' ? 'badge-custom-green' : 'bg-primary bg-opacity-25 text-primary border border-primary border-opacity-25')}">
                                                <c:out value="${skill.proficiencyLevel}" />
                                            </span>
                                        </div>
                                        <c:if test="${not empty skill.description}">
                                            <p class="small text-muted mb-3"><c:out value="${skill.description}" /></p>
                                        </c:if>
                                        <div class="d-flex gap-2 mt-auto">
                                            <a href="${pageContext.request.contextPath}/skills?editId=${skill.id}"
                                               class="btn btn-sm btn-outline-custom flex-fill">
                                                <i class="fa-solid fa-pen me-1"></i> Edit
                                            </a>
                                            <form action="${pageContext.request.contextPath}/skills" method="POST"
                                                  onsubmit="return confirm('Delete this skill?');" class="flex-fill">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="skillId" value="${skill.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger w-100">
                                                    <i class="fa-solid fa-trash me-1"></i> Delete
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fa-solid fa-folder-open display-4 text-muted mb-3 opacity-50"></i>
                            <p class="text-muted">You haven't added any skills yet.</p>
                            <p class="text-muted small">Use the form on the left to add your first skill!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
