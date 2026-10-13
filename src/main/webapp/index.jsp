<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Campus SkillConnect — Peer Skill Exchange" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5 my-md-4">
    <!-- Hero Section -->
    <div class="row align-items-center gy-5">
        <div class="col-lg-6 text-center text-lg-start">
            <span class="badge badge-custom-purple px-3 py-2 rounded-pill mb-3">
                <i class="fa-solid fa-sparkles me-1"></i> Multi-Campus Collaboration Platform
            </span>
            <h1 class="display-4 fw-extrabold mb-4" style="line-height: 1.15;">
                Connect, Share Skills &amp; Build <span style="background: linear-gradient(135deg, #7f5af0, #00f2fe); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Together.</span>
            </h1>
            <p class="lead text-muted mb-4 fs-5" style="max-width: 520px;">
                Find students across top institutions like IIT Bombay, Anna University, and DU. Learn Java, AI/ML, UI/UX, or team up for hackathons and projects.
            </p>
            <div class="d-flex flex-column flex-sm-row gap-3 justify-content-center justify-content-lg-start">
                <a href="${pageContext.request.contextPath}/register" class="btn btn-primary-custom btn-lg">
                    Get Started Free <i class="fa-solid fa-arrow-right ms-2"></i>
                </a>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-custom btn-lg">
                    Student Login
                </a>
            </div>
            
            <!-- Quick Stats -->
            <div class="row mt-5 pt-3 g-3 border-top border-secondary border-opacity-25">
                <div class="col-4">
                    <h3 class="fw-bold text-white mb-0">5+</h3>
                    <small class="text-muted">Top Institutions</small>
                </div>
                <div class="col-4">
                    <h3 class="fw-bold text-white mb-0">50+</h3>
                    <small class="text-muted">Tech Skills</small>
                </div>
                <div class="col-4">
                    <h3 class="fw-bold text-white mb-0">100%</h3>
                    <small class="text-muted">Peer Learning</small>
                </div>
            </div>
        </div>

        <!-- Hero Feature Card Illustration -->
        <div class="col-lg-6">
            <div class="glass-card position-relative overflow-hidden">
                <div class="d-flex align-items-center justify-content-between mb-4 pb-3 border-bottom border-secondary border-opacity-25">
                    <div class="d-flex align-items-center gap-3">
                        <div class="rounded-circle bg-purple p-3 text-white d-flex align-items-center justify-content-center" style="width: 48px; height: 48px; background: #7f5af0;">
                            <i class="fa-solid fa-code fs-5"></i>
                        </div>
                        <div>
                            <h6 class="mb-0 fw-bold">Live Skill Matcher</h6>
                            <small class="text-muted">Real-time Student Search</small>
                        </div>
                    </div>
                    <span class="badge badge-custom-green px-3 py-1 rounded-pill">Active</span>
                </div>

                <!-- Preview Search Card -->
                <div class="p-3 mb-3 rounded-3" style="background: rgba(15, 20, 32, 0.6); border: 1px solid rgba(255,255,255,0.08);">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <span class="fw-semibold text-white">Full Stack Java &amp; Spring Boot</span>
                        <span class="badge badge-custom-blue">Advanced</span>
                    </div>
                    <p class="small text-muted mb-0">IIT Bombay &bull; Powai Main Campus</p>
                </div>

                <div class="p-3 mb-3 rounded-3" style="background: rgba(15, 20, 32, 0.6); border: 1px solid rgba(255,255,255,0.08);">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <span class="fw-semibold text-white">UI/UX Design &amp; Figma</span>
                        <span class="badge badge-custom-green">Intermediate</span>
                    </div>
                    <p class="small text-muted mb-0">Anna University &bull; CEG Campus</p>
                </div>

                <div class="p-3 rounded-3" style="background: rgba(15, 20, 32, 0.6); border: 1px solid rgba(255,255,255,0.08);">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <span class="fw-semibold text-white">Machine Learning &amp; Python</span>
                        <span class="badge badge-custom-cyan">Advanced</span>
                    </div>
                    <p class="small text-muted mb-0">Delhi University &bull; North Campus</p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
