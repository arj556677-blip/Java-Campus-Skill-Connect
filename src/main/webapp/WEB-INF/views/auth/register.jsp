<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Create Account — Campus SkillConnect" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
            <div class="glass-card">
                <div class="text-center mb-4">
                    <div class="d-inline-flex align-items-center justify-content-center rounded-circle p-3 mb-3" style="width: 56px; height: 56px; background: rgba(44, 182, 125, 0.15); border: 1px solid rgba(44, 182, 125, 0.3);">
                        <i class="fa-solid fa-user-plus fs-4" style="color: #2cb67d;"></i>
                    </div>
                    <h3 class="fw-bold mb-1">Create Student Profile</h3>
                    <p class="text-muted small">Join your campus community and share your technical skills</p>
                </div>

                <!-- Backend Error Alert -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-custom-danger p-3 mb-4 d-flex align-items-center gap-2" role="alert">
                        <i class="fa-solid fa-circle-exclamation fs-5"></i>
                        <div><c:out value="${errorMessage}" /></div>
                    </div>
                </c:if>

                <!-- Client-Side JS Validation Error Alert -->
                <div id="jsValidationError" class="alert alert-custom-danger p-3 mb-4 d-none align-items-center gap-2" role="alert">
                    <i class="fa-solid fa-circle-exclamation fs-5"></i>
                    <div id="jsValidationText"></div>
                </div>

                <!-- Registration Form -->
                <form action="${pageContext.request.contextPath}/register" method="POST" id="registerForm" novalidate>
                    
                    <!-- Step 1: Personal Info -->
                    <h6 class="fw-bold text-uppercase tracking-wider text-muted small mb-3">
                        <i class="fa-solid fa-id-card me-1" style="color: #7f5af0;"></i> Personal Details
                    </h6>
                    
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label for="firstName" class="form-label">First Name *</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" value="<c:out value='${firstName}' />" required placeholder="John">
                        </div>
                        <div class="col-md-6">
                            <label for="lastName" class="form-label">Last Name *</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" value="<c:out value='${lastName}' />" required placeholder="Doe">
                        </div>
                        <div class="col-12">
                            <label for="email" class="form-label">Student Email *</label>
                            <input type="email" class="form-control" id="email" name="email" value="<c:out value='${email}' />" required placeholder="john.doe@institution.edu">
                        </div>
                        <div class="col-md-6">
                            <label for="password" class="form-label">Password *</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" name="password" required placeholder="At least 6 characters" style="border-radius: 12px 0 0 12px !important;">
                                <button class="btn btn-outline-secondary bg-dark border-secondary text-muted border-opacity-25 px-3" type="button" onclick="togglePasswordVisibility('password', 'togglePasswordIcon1')" style="border-radius: 0 12px 12px 0;">
                                    <i class="fa-solid fa-eye" id="togglePasswordIcon1"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="confirmPassword" class="form-label">Confirm Password *</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required placeholder="Re-enter password" style="border-radius: 12px 0 0 12px !important;">
                                <button class="btn btn-outline-secondary bg-dark border-secondary text-muted border-opacity-25 px-3" type="button" onclick="togglePasswordVisibility('confirmPassword', 'togglePasswordIcon2')" style="border-radius: 0 12px 12px 0;">
                                    <i class="fa-solid fa-eye" id="togglePasswordIcon2"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Step 2: Academic Info -->
                    <h6 class="fw-bold text-uppercase tracking-wider text-muted small mb-3">
                        <i class="fa-solid fa-building-columns me-1" style="color: #7f5af0;"></i> Institution &amp; Campus
                    </h6>

                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label for="institutionId" class="form-label">Institution *</label>
                            <select class="form-select" id="institutionId" name="institutionId" required onchange="loadCampuses(this.value)">
                                <option value="">Select Institution</option>
                                <c:forEach items="${institutions}" var="inst">
                                    <option value="${inst.id}"><c:out value="${inst.name}" /> (<c:out value="${inst.city}" />)</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="campusId" class="form-label">Campus *</label>
                            <select class="form-select" id="campusId" name="campusId" required disabled>
                                <option value="">Select Institution First</option>
                            </select>
                        </div>
                        <div class="col-md-8">
                            <label for="course" class="form-label">Degree / Course</label>
                            <input type="text" class="form-control" id="course" name="course" value="<c:out value='${course}' />" placeholder="e.g. Master of Computer Applications (MCA)">
                        </div>
                        <div class="col-md-4">
                            <label for="yearOfStudy" class="form-label">Year of Study</label>
                            <select class="form-select" id="yearOfStudy" name="yearOfStudy">
                                <option value="1" ${yearOfStudy eq '1' ? 'selected' : ''}>1st Year</option>
                                <option value="2" ${yearOfStudy eq '2' ? 'selected' : ''}>2nd Year</option>
                                <option value="3" ${yearOfStudy eq '3' ? 'selected' : ''}>3rd Year</option>
                                <option value="4" ${yearOfStudy eq '4' ? 'selected' : ''}>4th Year</option>
                                <option value="5" ${yearOfStudy eq '5' ? 'selected' : ''}>5th Year</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label for="bio" class="form-label">Short Bio / About You</label>
                            <textarea class="form-control" id="bio" name="bio" rows="3" placeholder="Tell other students about your interests, project goals, or tech stack..."><c:out value="${bio}" /></textarea>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary-custom w-100 py-3 mb-4 fs-6">
                        Complete Registration <i class="fa-solid fa-user-check ms-2"></i>
                    </button>
                </form>

                <div class="text-center text-muted small">
                    Already registered? 
                    <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-decoration-none" style="color: #7f5af0;">
                        Log In Here
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Dynamic AJAX Campus Loader Script -->
<script>
function loadCampuses(institutionId) {
    const campusSelect = document.getElementById('campusId');
    campusSelect.innerHTML = '<option value="">Loading Campuses...</option>';
    campusSelect.disabled = true;

    if (!institutionId) {
        campusSelect.innerHTML = '<option value="">Select Institution First</option>';
        return;
    }

    fetch('${pageContext.request.contextPath}/api/campuses?institutionId=' + institutionId)
        .then(response => response.json())
        .then(campuses => {
            campusSelect.innerHTML = '<option value="">Select Campus</option>';
            if (campuses.length === 0) {
                campusSelect.innerHTML = '<option value="">No campuses available</option>';
                return;
            }
            campuses.forEach(campus => {
                const opt = document.createElement('option');
                opt.value = campus.id;
                opt.textContent = campus.name + (campus.city ? ' (' + campus.city + ')' : '');
                campusSelect.appendChild(opt);
            });
            campusSelect.disabled = false;
        })
        .catch(err => {
            console.error('Failed to fetch campuses:', err);
            campusSelect.innerHTML = '<option value="">Error loading campuses</option>';
        });
}

// Password Visibility Toggle
function togglePasswordVisibility(inputId, iconId) {
    const pwdInput = document.getElementById(inputId);
    const icon = document.getElementById(iconId);
    if (pwdInput.type === 'password') {
        pwdInput.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        pwdInput.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
}

// Client-Side JS Form Validation (Phase 3 Requirement)
document.getElementById('registerForm')?.addEventListener('submit', function (e) {
    const firstName = document.getElementById('firstName').value.trim();
    const lastName = document.getElementById('lastName').value.trim();
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value.trim();
    const confirmPassword = document.getElementById('confirmPassword').value.trim();
    const institutionId = document.getElementById('institutionId').value;
    const campusId = document.getElementById('campusId').value;

    const errorContainer = document.getElementById('jsValidationError');
    const errorText = document.getElementById('jsValidationText');

    errorContainer.classList.add('d-none');
    errorContainer.classList.remove('d-flex');

    function showError(msg) {
        e.preventDefault();
        errorText.textContent = msg;
        errorContainer.classList.remove('d-none');
        errorContainer.classList.add('d-flex');
        window.scrollTo({ top: errorContainer.offsetTop - 100, behavior: 'smooth' });
        return false;
    }

    if (!firstName || !lastName || !email || !password || !confirmPassword || !institutionId || !campusId) {
        return showError("Please fill in all required fields (marked with *).");
    }

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        return showError("Please enter a valid email address format (e.g., student@institution.edu).");
    }

    if (password.length < 6) {
        return showError("Password must be at least 6 characters long.");
    }

    if (password !== confirmPassword) {
        return showError("Passwords do not match. Please verify your password.");
    }
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
