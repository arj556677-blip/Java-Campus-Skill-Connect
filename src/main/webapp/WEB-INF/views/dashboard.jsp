<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Dashboard — Campus SkillConnect" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-4">
    <!-- Welcome Header -->
    <div class="glass-card mb-4 py-4">
        <div class="row align-items-center g-3">
            <div class="col-md-8">
                <span class="badge badge-custom-purple px-3 py-1 mb-2">Student Dashboard</span>
                <h2 class="fw-bold mb-1">Welcome back, <c:out value="${sessionScope.loggedInUser.firstName}" />! 👋</h2>
                <p class="text-muted mb-0">
                    <i class="fa-solid fa-building-columns me-1"></i> <c:out value="${sessionScope.loggedInUser.institutionName}" /> 
                    &bull; <i class="fa-solid fa-location-dot me-1"></i> <c:out value="${sessionScope.loggedInUser.campusName}" />
                    <c:if test="${not empty sessionScope.loggedInUser.course}">
                        &bull; <c:out value="${sessionScope.loggedInUser.course}" /> (Year <c:out value="${sessionScope.loggedInUser.yearOfStudy}" />)
                    </c:if>
                </p>
            </div>
            <div class="col-md-4 text-md-end">
                <a href="${pageContext.request.contextPath}/skills" class="btn btn-primary-custom btn-sm me-2">
                    <i class="fa-solid fa-plus me-1"></i> Add Skill
                </a>
                <a href="${pageContext.request.contextPath}/search" class="btn btn-outline-custom btn-sm">
                    <i class="fa-solid fa-magnifying-glass me-1"></i> Find Partners
                </a>
            </div>
        </div>
    </div>

    <!-- Overview Cards Grid -->
    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="glass-card p-4 h-100">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <span class="text-muted fw-semibold">My Listed Skills</span>
                    <div class="rounded-circle p-2" style="background: rgba(127, 90, 240, 0.15); color: #7f5af0;">
                        <i class="fa-solid fa-lightbulb fs-5"></i>
                    </div>
                </div>
                <h2 class="display-6 fw-bold mb-1">${userSkills != null ? userSkills.size() : 0}</h2>
                <small class="text-muted">Skills shared on your profile</small>
            </div>
        </div>

        <div class="col-md-4">
            <div class="glass-card p-4 h-100">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <span class="text-muted fw-semibold">Pending Requests</span>
                    <div class="rounded-circle p-2" style="background: rgba(245, 158, 11, 0.15); color: #f59e0b;">
                        <i class="fa-solid fa-clock-rotate-left fs-5"></i>
                    </div>
                </div>
                <h2 class="display-6 fw-bold mb-1 text-warning">${pendingCount != null ? pendingCount : 0}</h2>
                <small class="text-muted">Incoming requests awaiting your response</small>
            </div>
        </div>

        <div class="col-md-4">
            <div class="glass-card p-4 h-100">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <span class="text-muted fw-semibold">Sent Requests</span>
                    <div class="rounded-circle p-2" style="background: rgba(44, 182, 125, 0.15); color: #2cb67d;">
                        <i class="fa-solid fa-paper-plane fs-5"></i>
                    </div>
                </div>
                <h2 class="display-6 fw-bold mb-1">${sentRequests != null ? sentRequests.size() : 0}</h2>
                <small class="text-muted">Collaboration offers you sent to peers</small>
            </div>
        </div>
    </div>

    <!-- Skills List Section -->
    <div class="row g-4">
        <div class="col-lg-8">
            <div class="glass-card">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h5 class="fw-bold mb-0">
                        <i class="fa-solid fa-brain me-2" style="color: #7f5af0;"></i> My Skills Portfolio
                    </h5>
                    <a href="${pageContext.request.contextPath}/skills" class="btn btn-outline-custom btn-sm">Manage Skills</a>
                </div>

                <c:choose>
                    <c:when test="${not empty userSkills}">
                        <div class="row g-3">
                            <c:forEach items="${userSkills}" var="skill">
                                <div class="col-md-6">
                                    <div class="p-3 rounded-3 h-100" style="background: rgba(15, 20, 32, 0.6); border: 1px solid rgba(255, 255, 255, 0.08);">
                                        <div class="d-flex align-items-center justify-content-between mb-2">
                                            <h6 class="fw-bold text-white mb-0"><c:out value="${skill.skillName}" /></h6>
                                            <span class="badge ${skill.proficiencyLevel eq 'BEGINNER' ? 'badge-custom-purple' : (skill.proficiencyLevel eq 'INTERMEDIATE' ? 'badge-custom-green' : 'bg-primary bg-opacity-25 text-primary border border-primary border-opacity-25')}">
                                                <c:out value="${skill.proficiencyLevel}" />
                                            </span>
                                        </div>
                                        <c:if test="${not empty skill.description}">
                                            <p class="small text-muted mb-0"><c:out value="${skill.description}" /></p>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fa-solid fa-folder-open display-4 text-muted mb-3 opacity-50"></i>
                            <p class="text-muted mb-3">You haven't listed any skills yet!</p>
                            <a href="${pageContext.request.contextPath}/skills" class="btn btn-primary-custom btn-sm">
                                <i class="fa-solid fa-plus me-1"></i> Add Your First Skill
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Right Side: Quick Profile Summary -->
        <div class="col-lg-4">
            <div class="glass-card">
                <h5 class="fw-bold mb-3">
                    <i class="fa-solid fa-id-badge me-2" style="color: #2cb67d;"></i> Profile Summary
                </h5>
                <div class="mb-3">
                    <small class="text-muted d-block">Full Name</small>
                    <span class="fw-semibold text-white"><c:out value="${sessionScope.loggedInUser.fullName}" /></span>
                </div>
                <div class="mb-3">
                    <small class="text-muted d-block">Email</small>
                    <span class="fw-semibold text-white"><c:out value="${sessionScope.loggedInUser.email}" /></span>
                </div>
                <div class="mb-3">
                    <small class="text-muted d-block">Institution</small>
                    <span class="fw-semibold text-white"><c:out value="${sessionScope.loggedInUser.institutionName}" /></span>
                </div>
                <div class="mb-3">
                    <small class="text-muted d-block">Campus</small>
                    <span class="fw-semibold text-white"><c:out value="${sessionScope.loggedInUser.campusName}" /></span>
                </div>
                <c:if test="${not empty sessionScope.loggedInUser.bio}">
                    <div class="mb-0">
                        <small class="text-muted d-block">Bio</small>
                        <span class="small text-white opacity-85"><c:out value="${sessionScope.loggedInUser.bio}" /></span>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
