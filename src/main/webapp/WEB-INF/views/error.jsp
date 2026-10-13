<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Error — Campus SkillConnect" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5 my-5 text-center">
    <div class="glass-card mx-auto" style="max-width: 550px;">
        <div class="d-inline-flex align-items-center justify-content-center rounded-circle p-3 mb-3" style="width: 70px; height: 70px; background: rgba(239, 68, 68, 0.15); border: 1px solid rgba(239, 68, 68, 0.3);">
            <i class="fa-solid fa-triangle-exclamation text-danger fs-2"></i>
        </div>
        <h2 class="fw-bold mb-2">Oops! Something went wrong</h2>
        <p class="text-muted mb-4">
            <c:choose>
                <c:when test="${not empty pageContext.exception}">
                    <c:out value="${pageContext.exception.message}" />
                </c:when>
                <c:otherwise>
                    The page you are looking for might have been moved or is temporarily unavailable.
                </c:otherwise>
            </c:choose>
        </p>
        <div class="d-flex gap-3 justify-content-center">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-custom">
                <i class="fa-solid fa-house me-1"></i> Return Home
            </a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary-custom">
                <i class="fa-solid fa-gauge me-1"></i> Go to Dashboard
            </a>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
