<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Log In — Campus SkillConnect" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="glass-card">
                <div class="text-center mb-4">
                    <div class="d-inline-flex align-items-center justify-content-center rounded-circle p-3 mb-3" style="width: 56px; height: 56px; background: rgba(127, 90, 240, 0.15); border: 1px solid rgba(127, 90, 240, 0.3);">
                        <i class="fa-solid fa-lock text-purple fs-4" style="color: #7f5af0;"></i>
                    </div>
                    <h3 class="fw-bold mb-1">Welcome Back</h3>
                    <p class="text-muted small">Log in to access your skills and collaboration requests</p>
                </div>

                <!-- Error Messages -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-custom-danger p-3 mb-4 d-flex align-items-center gap-2" role="alert">
                        <i class="fa-solid fa-circle-exclamation fs-5"></i>
                        <div><c:out value="${errorMessage}" /></div>
                    </div>
                </c:if>

                <c:if test="${param.loggedOut eq 'true'}">
                    <div class="alert alert-custom-success p-3 mb-4 d-flex align-items-center gap-2" role="alert">
                        <i class="fa-solid fa-circle-check fs-5"></i>
                        <div>You have been logged out successfully.</div>
                    </div>
                </c:if>

                <c:if test="${param.unauthorized eq 'true'}">
                    <div class="alert alert-custom-danger p-3 mb-4 d-flex align-items-center gap-2" role="alert">
                        <i class="fa-solid fa-triangle-exclamation fs-5"></i>
                        <div>Please log in to access that page.</div>
                    </div>
                </c:if>

                <!-- Client-Side Validation Error Container -->
                <div id="jsValidationError" class="alert alert-custom-danger p-3 mb-4 d-none align-items-center gap-2" role="alert">
                    <i class="fa-solid fa-circle-exclamation fs-5"></i>
                    <div id="jsValidationText"></div>
                </div>

                <!-- Login Form -->
                <form action="${pageContext.request.contextPath}/login" method="POST" id="loginForm" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text bg-dark border-secondary text-muted border-opacity-25" style="border-radius: 12px 0 0 12px;">
                                <i class="fa-solid fa-envelope"></i>
                            </span>
                            <input type="email" class="form-control" id="email" name="email" value="<c:out value='${email}' />" placeholder="student@institution.edu" required style="border-radius: 0 12px 12px 0 !important;">
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label for="password" class="form-label mb-0">Password</label>
                        </div>
                        <div class="input-group">
                            <span class="input-group-text bg-dark border-secondary text-muted border-opacity-25" style="border-radius: 12px 0 0 12px;">
                                <i class="fa-solid fa-key"></i>
                            </span>
                            <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required style="border-radius: 0 !important;">
                            <button class="btn btn-outline-secondary bg-dark border-secondary text-muted border-opacity-25 px-3" type="button" id="togglePassword" style="border-radius: 0 12px 12px 0;">
                                <i class="fa-solid fa-eye" id="togglePasswordIcon"></i>
                            </button>
                        </div>
                    </div>

                    <script>
                        document.getElementById('togglePassword')?.addEventListener('click', function () {
                            const pwdInput = document.getElementById('password');
                            const icon = document.getElementById('togglePasswordIcon');
                            if (pwdInput.type === 'password') {
                                pwdInput.type = 'text';
                                icon.classList.remove('fa-eye');
                                icon.classList.add('fa-eye-slash');
                            } else {
                                pwdInput.type = 'password';
                                icon.classList.remove('fa-eye-slash');
                                icon.classList.add('fa-eye');
                            }
                        });

                        // Client-Side JS Validation as per Phase 3 requirements
                        document.getElementById('loginForm')?.addEventListener('submit', function (e) {
                            const email = document.getElementById('email').value.trim();
                            const password = document.getElementById('password').value.trim();
                            const errorContainer = document.getElementById('jsValidationError');
                            const errorText = document.getElementById('jsValidationText');

                            errorContainer.classList.add('d-none');
                            errorContainer.classList.remove('d-flex');

                            if (!email || !password) {
                                e.preventDefault();
                                errorText.textContent = "Please fill in all required fields (Email and Password).";
                                errorContainer.classList.remove('d-none');
                                errorContainer.classList.add('d-flex');
                                return false;
                            }

                            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                            if (!emailPattern.test(email)) {
                                e.preventDefault();
                                errorText.textContent = "Please enter a valid email address (e.g., student@institution.edu).";
                                errorContainer.classList.remove('d-none');
                                errorContainer.classList.add('d-flex');
                                return false;
                            }

                            if (password.length < 6) {
                                e.preventDefault();
                                errorText.textContent = "Password must be at least 6 characters long.";
                                errorContainer.classList.remove('d-none');
                                errorContainer.classList.add('d-flex');
                                return false;
                            }
                        });
                    </script>

                    <button type="submit" class="btn btn-primary-custom w-100 py-3 mb-4 fs-6">
                        Log In <i class="fa-solid fa-arrow-right-to-bracket ms-2"></i>
                    </button>
                </form>

                <div class="text-center text-muted small">
                    Don't have an account yet? 
                    <a href="${pageContext.request.contextPath}/register" class="fw-semibold text-decoration-none" style="color: #2cb67d;">
                        Register Now
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
