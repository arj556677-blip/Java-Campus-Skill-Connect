<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="My Profile — Campus SkillConnect" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-4">

    <!-- Page Header -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-id-badge me-2" style="color:#2cb67d;"></i>My Profile</h3>
            <p class="text-muted mb-0">Keep your academic information and bio up to date.</p>
        </div>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-custom btn-sm">
            <i class="fa-solid fa-arrow-left me-1"></i> Dashboard
        </a>
    </div>

    <!-- Alerts -->
    <c:if test="${param.success eq 'true'}">
        <div class="alert alert-custom-success d-flex align-items-center gap-2 mb-4">
            <i class="fa-solid fa-circle-check fs-5"></i><div>Profile updated successfully!</div>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-custom-danger d-flex align-items-center gap-2 mb-4">
            <i class="fa-solid fa-circle-exclamation fs-5"></i><div><c:out value="${errorMessage}" /></div>
        </div>
    </c:if>

    <div class="row g-4">

        <!-- Avatar + Summary Card -->
        <div class="col-lg-4">
            <div class="glass-card text-center">
                <!-- Avatar Circle -->
                <div class="d-inline-flex align-items-center justify-content-center rounded-circle mb-3"
                     style="width: 90px; height: 90px; background: linear-gradient(135deg,#7f5af0,#2cb67d); font-size: 2.2rem; font-weight: 700; color: #fff;">
                    <c:out value="${sessionScope.loggedInUser.firstName.charAt(0)}" /><c:out value="${sessionScope.loggedInUser.lastName.charAt(0)}" />
                </div>
                <h4 class="fw-bold mb-1"><c:out value="${sessionScope.loggedInUser.fullName}" /></h4>
                <p class="text-muted small mb-3"><c:out value="${sessionScope.loggedInUser.email}" /></p>

                <hr class="border-secondary">

                <div class="text-start mt-3">
                    <div class="mb-2">
                        <small class="text-muted d-block">Institution</small>
                        <span class="fw-semibold"><c:out value="${sessionScope.loggedInUser.institutionName}" /></span>
                    </div>
                    <div class="mb-2">
                        <small class="text-muted d-block">Campus</small>
                        <span class="fw-semibold"><c:out value="${sessionScope.loggedInUser.campusName}" /></span>
                    </div>
                    <c:if test="${not empty sessionScope.loggedInUser.course}">
                        <div class="mb-2">
                            <small class="text-muted d-block">Course &amp; Year</small>
                            <span class="fw-semibold">
                                <c:out value="${sessionScope.loggedInUser.course}" />
                                <c:if test="${sessionScope.loggedInUser.yearOfStudy > 0}">
                                    (Year <c:out value="${sessionScope.loggedInUser.yearOfStudy}" />)
                                </c:if>
                            </span>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Edit Form -->
        <div class="col-lg-8">
            <div class="glass-card">
                <h5 class="fw-bold mb-4">
                    <i class="fa-solid fa-pen-to-square me-2" style="color:#7f5af0;"></i>Edit Profile Details
                </h5>

                <form action="${pageContext.request.contextPath}/profile" method="POST">

                    <h6 class="fw-semibold text-muted text-uppercase small mb-3">Personal Information</h6>
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label for="firstName" class="form-label">First Name *</label>
                            <input type="text" class="form-control" id="firstName" name="firstName"
                                   value="<c:out value='${sessionScope.loggedInUser.firstName}' />" required>
                        </div>
                        <div class="col-md-6">
                            <label for="lastName" class="form-label">Last Name *</label>
                            <input type="text" class="form-control" id="lastName" name="lastName"
                                   value="<c:out value='${sessionScope.loggedInUser.lastName}' />" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label text-muted">Email Address</label>
                            <input type="email" class="form-control" value="<c:out value='${sessionScope.loggedInUser.email}' />"
                                   disabled title="Email cannot be changed">
                            <div class="form-text text-muted">Email cannot be changed after registration.</div>
                        </div>
                    </div>

                    <h6 class="fw-semibold text-muted text-uppercase small mb-3">Academic Information</h6>
                    <div class="row g-3 mb-4">
                        <div class="col-md-8">
                            <label for="course" class="form-label">Degree / Course</label>
                            <input type="text" class="form-control" id="course" name="course"
                                   value="<c:out value='${sessionScope.loggedInUser.course}' />"
                                   placeholder="e.g. Master of Computer Applications (MCA)">
                        </div>
                        <div class="col-md-4">
                            <label for="yearOfStudy" class="form-label">Year of Study</label>
                            <select class="form-select" id="yearOfStudy" name="yearOfStudy">
                                <c:forEach begin="1" end="5" var="y">
                                    <option value="${y}" ${sessionScope.loggedInUser.yearOfStudy eq y ? 'selected' : ''}>
                                        <c:out value="${y}" />st/nd/rd/th Year
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-12">
                            <label for="bio" class="form-label">Short Bio / About You</label>
                            <textarea class="form-control" id="bio" name="bio" rows="4"
                                      placeholder="Tell other students about your interests, project goals, or tech stack..."><c:out value='${sessionScope.loggedInUser.bio}' /></textarea>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary-custom px-4">
                        <i class="fa-solid fa-floppy-disk me-2"></i>Save Profile
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
