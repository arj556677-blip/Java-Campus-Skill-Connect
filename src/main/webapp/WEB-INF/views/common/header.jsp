<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle}" default="Campus SkillConnect" /></title>
    
    <!-- Google Fonts: Plus Jakarta Sans & Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- FontAwesome 6.5 Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    
    <!-- Global Custom Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    
    <style>
        :root {
            --bg-dark: #0b0f19;
            --bg-card: rgba(22, 27, 38, 0.75);
            --bg-card-hover: rgba(30, 38, 54, 0.85);
            --accent-purple: #7f5af0;
            --accent-green: #2cb67d;
            --accent-cyan: #00f2fe;
            --text-primary: #ffffff;
            --text-muted: #cbd5e1;
            --border-glass: rgba(255, 255, 255, 0.12);
            --glass-blur: blur(16px);
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-dark);
            background-image: 
                radial-gradient(circle at 15% 15%, rgba(127, 90, 240, 0.12) 0%, transparent 40%),
                radial-gradient(circle at 85% 85%, rgba(44, 182, 125, 0.1) 0%, transparent 40%);
            background-attachment: fixed;
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        h1, h2, h3, h4, h5, h6, .navbar-brand {
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        /* Glassmorphism Navigation Bar */
        .navbar-custom {
            background: rgba(11, 15, 25, 0.8) !important;
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            border-bottom: 1px solid var(--border-glass);
            padding: 0.8rem 0;
            position: sticky;
            top: 0;
            z-index: 1030;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.4rem;
            background: linear-gradient(135deg, var(--accent-purple), var(--accent-green));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-link {
            color: var(--text-muted) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            transition: all 0.2s ease;
            border-radius: 8px;
        }

        .nav-link:hover, .nav-link.active {
            color: var(--text-primary) !important;
            background: rgba(255, 255, 255, 0.05);
        }

        /* Modern Glass Card */
        .glass-card {
            background: var(--bg-card);
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            border: 1px solid var(--border-glass);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            padding: 2.5rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .glass-card:hover {
            border-color: rgba(127, 90, 240, 0.3);
        }

        /* Custom Form Controls */
        .form-control, .form-select {
            background-color: rgba(15, 20, 32, 0.8) !important;
            border: 1px solid rgba(255, 255, 255, 0.12) !important;
            color: var(--text-primary) !important;
            border-radius: 12px !important;
            padding: 0.75rem 1rem !important;
            transition: all 0.25s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--accent-purple) !important;
            box-shadow: 0 0 0 4px rgba(127, 90, 240, 0.25) !important;
        }

        .text-muted {
            color: #cbd5e1 !important;
        }

        .form-label {
            color: #f1f5f9 !important;
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 0.4rem;
        }

        select option {
            background-color: #0f1420 !important;
            color: #ffffff !important;
        }

        /* Premium Buttons */
        .btn-primary-custom {
            background: linear-gradient(135deg, var(--accent-purple), #6246ea);
            color: #ffffff;
            border: none;
            font-weight: 600;
            padding: 0.75rem 1.8rem;
            border-radius: 12px;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(127, 90, 240, 0.3);
        }

        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(127, 90, 240, 0.45);
            color: #ffffff;
        }

        .btn-outline-custom {
            background: transparent;
            color: var(--text-primary);
            border: 1px solid rgba(255, 255, 255, 0.2);
            font-weight: 600;
            padding: 0.75rem 1.8rem;
            border-radius: 12px;
            transition: all 0.3s ease;
        }

        .btn-outline-custom:hover {
            background: rgba(255, 255, 255, 0.08);
            border-color: rgba(255, 255, 255, 0.4);
            color: var(--text-primary);
        }

        /* Badge Styles */
        .badge-custom-purple {
            background: rgba(127, 90, 240, 0.25);
            color: #c4b5fd;
            border: 1px solid rgba(127, 90, 240, 0.4);
        }

        .badge-custom-green {
            background: rgba(44, 182, 125, 0.25);
            color: #6ee7b7;
            border: 1px solid rgba(44, 182, 125, 0.4);
        }

        .badge-custom-blue {
            background: rgba(59, 130, 246, 0.25);
            color: #93c5fd;
            border: 1px solid rgba(59, 130, 246, 0.4);
        }

        .badge-custom-cyan {
            background: rgba(6, 182, 212, 0.25);
            color: #67e8f9;
            border: 1px solid rgba(6, 182, 212, 0.4);
        }

        /* Alert Banners */
        .alert-custom-danger {
            background: rgba(239, 68, 68, 0.15);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #fca5a5;
            border-radius: 12px;
        }

        .alert-custom-success {
            background: rgba(34, 197, 94, 0.15);
            border: 1px solid rgba(34, 197, 94, 0.3);
            color: #86efac;
            border-radius: 12px;
        }
    </style>
</head>
<body>
    <!-- Defeat browser back-forward cache (bfcache) — forces server reload on back/forward navigation -->
    <script>
        window.addEventListener('pageshow', function(event) {
            if (event.persisted || (window.performance && window.performance.getEntriesByType('navigation').length > 0 &&
                window.performance.getEntriesByType('navigation')[0].type === 'back_forward')) {
                window.location.reload();
            }
        });
    </script>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fa-solid fa-graduation-cap text-gradient"></i>
                Campus SkillConnect
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center gap-2">
                    <c:choose>
                        <c:when test="${not empty sessionScope.loggedInUser}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                                    <i class="fa-solid fa-gauge me-1"></i> Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/skills">
                                    <i class="fa-solid fa-lightbulb me-1"></i> My Skills
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/requests">
                                    <i class="fa-solid fa-paper-plane me-1"></i> Requests
                                </a>
                            </li>
                            <li class="nav-item dropdown ms-lg-2">
                                <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                    <div class="rounded-circle bg-purple d-flex align-items-center justify-content-center text-white font-weight-bold" style="width: 34px; height: 34px; background: #7f5af0;">
                                        <c:out value="${sessionScope.loggedInUser.firstName.charAt(0)}" />
                                    </div>
                                    <span><c:out value="${sessionScope.loggedInUser.firstName}" /></span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end shadow-lg border-secondary mt-2">
                                    <li>
                                        <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/profile">
                                            <i class="fa-solid fa-user me-2 text-muted"></i> My Profile
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider border-secondary"></li>
                                    <li>
                                        <a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout">
                                            <i class="fa-solid fa-right-from-bracket me-2"></i> Sign Out
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/">
                                    <i class="fa-solid fa-house me-1"></i> Home
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">Log In</a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-primary-custom btn-sm ms-2" href="${pageContext.request.contextPath}/register">
                                    Join Now
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <main class="flex-grow-1">
