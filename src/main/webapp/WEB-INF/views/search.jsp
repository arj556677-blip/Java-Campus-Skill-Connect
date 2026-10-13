<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Find Students — Campus SkillConnect" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-4">

    <!-- Page Header -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-magnifying-glass me-2" style="color:#7f5af0;"></i>Find Skill Partners</h3>
            <p class="text-muted mb-0">Search for students by skill to find collaboration partners.</p>
        </div>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-custom btn-sm">
            <i class="fa-solid fa-arrow-left me-1"></i> Dashboard
        </a>
    </div>

    <!-- ── Viewing another student's profile ── -->
    <c:if test="${not empty targetUser}">
        <div class="glass-card mb-4">
            <div class="row align-items-center g-3">
                <div class="col-auto">
                    <div class="d-flex align-items-center justify-content-center rounded-circle"
                         style="width:64px;height:64px;background:linear-gradient(135deg,#7f5af0,#2cb67d);font-size:1.6rem;font-weight:700;color:#fff;">
                        <c:out value="${targetUser.firstName.charAt(0)}" />
                    </div>
                </div>
                <div class="col">
                    <h4 class="fw-bold mb-0"><c:out value="${targetUser.fullName}" /></h4>
                    <p class="text-muted small mb-1">
                        <i class="fa-solid fa-building-columns me-1"></i><c:out value="${targetUser.institutionName}" />
                        &bull; <i class="fa-solid fa-location-dot me-1"></i><c:out value="${targetUser.campusName}" />
                        <c:if test="${not empty targetUser.course}">
                            &bull; <c:out value="${targetUser.course}" /> (Year <c:out value="${targetUser.yearOfStudy}" />)
                        </c:if>
                    </p>
                    <c:if test="${not empty targetUser.bio}">
                        <p class="small text-muted mb-0"><c:out value="${targetUser.bio}" /></p>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Target user's skills + request buttons -->
        <c:choose>
            <c:when test="${not empty targetSkills}">
                <h5 class="fw-bold mb-3">
                    <i class="fa-solid fa-lightbulb me-2" style="color:#7f5af0;"></i>
                    <c:out value="${targetUser.firstName}" />'s Skills
                </h5>
                <div class="row g-3 mb-4">
                    <c:forEach items="${targetSkills}" var="skill">
                        <div class="col-md-4">
                            <div class="glass-card p-3">
                                <div class="d-flex align-items-start justify-content-between mb-2">
                                    <h6 class="fw-bold mb-0 me-2"><c:out value="${skill.skillName}" /></h6>
                                    <span class="badge flex-shrink-0 ${skill.proficiencyLevel.name() eq 'BEGINNER' ? 'badge-custom-purple' : (skill.proficiencyLevel.name() eq 'INTERMEDIATE' ? 'badge-custom-green' : 'bg-primary bg-opacity-25 text-primary border border-primary border-opacity-25')}">
                                        <c:out value="${skill.proficiencyLevel}" />
                                    </span>
                                </div>
                                <c:if test="${not empty skill.description}">
                                    <p class="small text-muted mb-3"><c:out value="${skill.description}" /></p>
                                </c:if>
                                <!-- Send Request button opens modal -->
                                <button class="btn btn-primary-custom btn-sm w-100"
                                        onclick="openRequestModal(${targetUser.id}, '${targetUser.fullName}', ${skill.id}, '${skill.skillName}')">
                                    <i class="fa-solid fa-paper-plane me-1"></i> Request Collaboration
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="glass-card text-center py-4 mb-4">
                    <i class="fa-solid fa-folder-open display-5 text-muted opacity-50 mb-2"></i>
                    <p class="text-muted"><c:out value="${targetUser.firstName}" /> hasn't listed any skills yet.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <a href="${pageContext.request.contextPath}/search" class="btn btn-outline-custom btn-sm mb-4">
            <i class="fa-solid fa-arrow-left me-1"></i> Back to Search
        </a>
        <hr class="border-secondary mb-4">
    </c:if>

    <!-- ── Search Form ── -->
    <div class="glass-card mb-4">
        <form action="${pageContext.request.contextPath}/search" method="GET" class="d-flex gap-3 align-items-end">
            <div class="flex-grow-1">
                <label for="q" class="form-label fw-semibold">Search by Skill</label>
                <input type="text" class="form-control form-control-lg" id="q" name="q"
                       placeholder="e.g. Java, Python, Web Design, Machine Learning..."
                       value="<c:out value='${query}' />">
            </div>
            <button type="submit" class="btn btn-primary-custom btn-lg px-4">
                <i class="fa-solid fa-search me-1"></i> Search
            </button>
            <c:if test="${not empty query}">
                <a href="${pageContext.request.contextPath}/search" class="btn btn-outline-custom btn-lg">Clear</a>
            </c:if>
        </form>
    </div>

    <!-- ── Search Results ── -->
    <c:if test="${not empty query}">
        <h5 class="fw-bold mb-3">
            Results for "<c:out value="${query}" />"
            <span class="text-muted fw-normal fs-6 ms-2">
                (${empty searchResults ? 0 : searchResults.size()} student<c:if test="${searchResults.size() != 1}">s</c:if> found)
            </span>
        </h5>

        <c:choose>
            <c:when test="${not empty searchResults}">
                <div class="row g-3">
                    <c:forEach items="${searchResults}" var="student">
                        <div class="col-md-6 col-lg-4">
                            <div class="glass-card h-100 p-3">
                                <div class="d-flex align-items-center gap-3 mb-3">
                                    <div class="d-flex align-items-center justify-content-center rounded-circle flex-shrink-0"
                                         style="width:48px;height:48px;background:linear-gradient(135deg,#7f5af0,#2cb67d);font-size:1.2rem;font-weight:700;color:#fff;">
                                        <c:out value="${student.firstName.charAt(0)}" />
                                    </div>
                                    <div>
                                        <h6 class="fw-bold mb-0"><c:out value="${student.fullName}" /></h6>
                                        <small class="text-muted">
                                            <c:out value="${student.institutionName}" />
                                            <c:if test="${not empty student.course}"> &bull; <c:out value="${student.course}" /></c:if>
                                        </small>
                                    </div>
                                </div>
                                <c:if test="${not empty student.bio}">
                                    <p class="small text-muted mb-3"><c:out value="${student.bio}" /></p>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/search?userId=${student.id}"
                                   class="btn btn-outline-custom btn-sm w-100">
                                    <i class="fa-solid fa-eye me-1"></i> View Profile &amp; Skills
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="glass-card text-center py-5">
                    <i class="fa-solid fa-user-slash display-4 text-muted opacity-50 mb-3"></i>
                    <p class="text-muted mb-1">No students found with the skill "<c:out value="${query}" />".</p>
                    <p class="small text-muted">Try a different keyword or check the spelling.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>

    <c:if test="${empty query and empty targetUser}">
        <div class="glass-card text-center py-5">
            <i class="fa-solid fa-people-group display-4 text-muted opacity-50 mb-3"></i>
            <p class="text-muted">Enter a skill name above to discover students on your campus!</p>
        </div>
    </c:if>

</div>

<!-- ── Send Request Modal ── -->
<div class="modal fade" id="requestModal" tabindex="-1" aria-labelledby="requestModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="background:#16213e;border:1px solid rgba(255,255,255,0.12);">
            <div class="modal-header border-secondary">
                <h5 class="modal-title fw-bold" id="requestModalLabel">
                    <i class="fa-solid fa-paper-plane me-2" style="color:#7f5af0;"></i>Request Collaboration
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/requests" method="POST">
                <div class="modal-body">
                    <input type="hidden" name="action" value="send">
                    <input type="hidden" name="toUserId"  id="modalToUserId">
                    <input type="hidden" name="skillId"   id="modalSkillId">

                    <p class="text-muted mb-3">
                        Sending a collaboration request to <strong id="modalStudentName"></strong>
                        for skill: <strong id="modalSkillName"></strong>
                    </p>

                    <div class="mb-3">
                        <label for="message" class="form-label">Message <span class="text-muted">(optional)</span></label>
                        <textarea class="form-control" id="message" name="message" rows="3"
                                  placeholder="Introduce yourself and explain what you'd like to work on together..."></textarea>
                    </div>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary-custom">
                        <i class="fa-solid fa-paper-plane me-1"></i> Send Request
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function openRequestModal(toUserId, studentName, skillId, skillName) {
    document.getElementById('modalToUserId').value    = toUserId;
    document.getElementById('modalSkillId').value     = skillId;
    document.getElementById('modalStudentName').textContent = studentName;
    document.getElementById('modalSkillName').textContent   = skillName;
    var modal = new bootstrap.Modal(document.getElementById('requestModal'));
    modal.show();
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
