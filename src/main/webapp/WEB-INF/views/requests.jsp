<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Requests — Campus SkillConnect" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-4">

    <!-- Page Header -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-paper-plane me-2" style="color:#7f5af0;"></i>Collaboration Requests</h3>
            <p class="text-muted mb-0">Manage incoming and outgoing skill-exchange requests.</p>
        </div>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-custom btn-sm">
            <i class="fa-solid fa-arrow-left me-1"></i> Dashboard
        </a>
    </div>

    <!-- Alerts -->
    <c:if test="${param.success eq 'sent'}">
        <div class="alert alert-custom-success d-flex align-items-center gap-2 mb-4">
            <i class="fa-solid fa-circle-check fs-5"></i><div>Collaboration request sent successfully!</div>
        </div>
    </c:if>
    <c:if test="${param.success eq 'accepted'}">
        <div class="alert alert-custom-success d-flex align-items-center gap-2 mb-4">
            <i class="fa-solid fa-circle-check fs-5"></i><div>Request accepted! You can now collaborate.</div>
        </div>
    </c:if>
    <c:if test="${param.success eq 'rejected'}">
        <div class="alert alert-custom-danger d-flex align-items-center gap-2 mb-4">
            <i class="fa-solid fa-circle-exclamation fs-5"></i><div>Request rejected.</div>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-custom-danger d-flex align-items-center gap-2 mb-4">
            <i class="fa-solid fa-circle-exclamation fs-5"></i><div><c:out value="${errorMessage}" /></div>
        </div>
    </c:if>

    <!-- Tabs -->
    <ul class="nav nav-pills mb-4 gap-2" id="requestTabs">
        <li class="nav-item">
            <button class="nav-link active btn-outline-custom px-4 py-2 fw-semibold" id="inboxTab"
                    onclick="switchTab('inbox', 'sent', this)">
                <i class="fa-solid fa-inbox me-1"></i> Inbox
                <c:if test="${pendingCount > 0}">
                    <span class="badge bg-danger ms-1"><c:out value="${pendingCount}" /></span>
                </c:if>
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link btn-outline-custom px-4 py-2 fw-semibold" id="sentTab"
                    onclick="switchTab('sent', 'inbox', this)">
                <i class="fa-solid fa-paper-plane me-1"></i> Sent
                <c:if test="${not empty sentRequests}">
                    <span class="badge badge-custom-purple ms-1"><c:out value="${sentRequests.size()}" /></span>
                </c:if>
            </button>
        </li>
    </ul>

    <!-- ── INBOX ── -->
    <div id="inbox-panel">
        <c:choose>
            <c:when test="${not empty receivedRequests}">
                <div class="row g-3">
                    <c:forEach items="${receivedRequests}" var="req">
                        <div class="col-12">
                            <div class="glass-card p-3">
                                <div class="row align-items-center g-3">
                                    <div class="col-auto">
                                        <div class="d-flex align-items-center justify-content-center rounded-circle"
                                             style="width:48px;height:48px;background:linear-gradient(135deg,#7f5af0,#2cb67d);font-size:1.2rem;font-weight:700;color:#fff;">
                                            <c:out value="${req.fromUserName.charAt(0)}" />
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="d-flex align-items-center gap-2 flex-wrap mb-1">
                                            <h6 class="fw-bold mb-0"><c:out value="${req.fromUserName}" /></h6>
                                            <span class="badge badge-custom-purple"><i class="fa-solid fa-lightbulb me-1"></i><c:out value="${req.skillName}" /></span>
                                            <span class="badge ${req.status.name() eq 'PENDING' ? 'bg-warning text-dark' : (req.status.name() eq 'ACCEPTED' ? 'badge-custom-green' : 'bg-danger bg-opacity-25 text-danger')}">
                                                <c:out value="${req.status}" />
                                            </span>
                                        </div>
                                        <c:if test="${not empty req.message}">
                                            <p class="small text-muted mb-1 fst-italic">"<c:out value="${req.message}" />"</p>
                                        </c:if>
                                        <small class="text-muted"><c:out value="${req.createdAt}" /></small>
                                    </div>
                                    <c:if test="${req.status.name() eq 'PENDING'}">
                                        <div class="col-auto d-flex gap-2">
                                            <form action="${pageContext.request.contextPath}/requests" method="POST">
                                                <input type="hidden" name="action" value="accept">
                                                <input type="hidden" name="requestId" value="${req.id}">
                                                <button type="submit" class="btn btn-sm btn-primary-custom">
                                                    <i class="fa-solid fa-check me-1"></i> Accept
                                                </button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/requests" method="POST">
                                                <input type="hidden" name="action" value="reject">
                                                <input type="hidden" name="requestId" value="${req.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger">
                                                    <i class="fa-solid fa-xmark me-1"></i> Reject
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="glass-card text-center py-5">
                    <i class="fa-solid fa-inbox display-4 text-muted opacity-50 mb-3"></i>
                    <p class="text-muted">No requests received yet. Share your skills so others can find you!</p>
                    <a href="${pageContext.request.contextPath}/skills" class="btn btn-primary-custom btn-sm mt-2">
                        <i class="fa-solid fa-lightbulb me-1"></i> Manage My Skills
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- ── SENT ── -->
    <div id="sent-panel" style="display:none;">
        <c:choose>
            <c:when test="${not empty sentRequests}">
                <div class="row g-3">
                    <c:forEach items="${sentRequests}" var="req">
                        <div class="col-12">
                            <div class="glass-card p-3">
                                <div class="row align-items-center g-3">
                                    <div class="col-auto">
                                        <div class="d-flex align-items-center justify-content-center rounded-circle"
                                             style="width:48px;height:48px;background:linear-gradient(135deg,#2cb67d,#7f5af0);font-size:1.2rem;font-weight:700;color:#fff;">
                                            <c:out value="${req.toUserName.charAt(0)}" />
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="d-flex align-items-center gap-2 flex-wrap mb-1">
                                            <span class="text-muted small">To:</span>
                                            <h6 class="fw-bold mb-0"><c:out value="${req.toUserName}" /></h6>
                                            <span class="badge badge-custom-purple"><i class="fa-solid fa-lightbulb me-1"></i><c:out value="${req.skillName}" /></span>
                                            <span class="badge ${req.status.name() eq 'PENDING' ? 'bg-warning text-dark' : (req.status.name() eq 'ACCEPTED' ? 'badge-custom-green' : 'bg-danger bg-opacity-25 text-danger')}">
                                                <c:out value="${req.status}" />
                                            </span>
                                        </div>
                                        <c:if test="${not empty req.message}">
                                            <p class="small text-muted mb-1 fst-italic">"<c:out value="${req.message}" />"</p>
                                        </c:if>
                                        <small class="text-muted"><c:out value="${req.createdAt}" /></small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="glass-card text-center py-5">
                    <i class="fa-solid fa-paper-plane display-4 text-muted opacity-50 mb-3"></i>
                    <p class="text-muted">You haven't sent any requests yet. Find a partner!</p>
                    <a href="${pageContext.request.contextPath}/search" class="btn btn-primary-custom btn-sm mt-2">
                        <i class="fa-solid fa-magnifying-glass me-1"></i> Find Students
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</div>

<script>
function switchTab(showId, hideId, activeBtn) {
    document.getElementById(showId + '-panel').style.display = '';
    document.getElementById(hideId + '-panel').style.display = 'none';
    document.getElementById(showId + 'Tab').classList.add('active');
    document.getElementById(hideId + 'Tab').classList.remove('active');
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
