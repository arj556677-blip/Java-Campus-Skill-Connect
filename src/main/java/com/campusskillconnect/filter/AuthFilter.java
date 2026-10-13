package com.campusskillconnect.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * AuthFilter — Security Filter to guard protected pages.
 *
 * Intercepts requests and checks if the user is authenticated.
 * Unauthenticated access to protected routes (/dashboard, /skills, etc.)
 * is redirected to the /login page.
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = uri.substring(contextPath.length());

        // Skip static resources (CSS, JS, images, fonts)
        boolean isStaticResource = path.startsWith("/css/") ||
                                   path.startsWith("/js/") ||
                                   path.startsWith("/images/") ||
                                   path.startsWith("/fonts/") ||
                                   path.startsWith("/api/");

        if (!isStaticResource) {
            // Apply no-cache headers to ALL dynamic pages to prevent
            // back-button from showing stale/cached pages
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
            response.setHeader("Pragma", "no-cache"); // HTTP 1.0
            response.setDateHeader("Expires", 0); // Proxies
        }

        // Check session state
        HttpSession session = request.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("loggedInUser") != null);

        // List of protected routes — require login
        boolean isProtected = path.startsWith("/dashboard") ||
                              path.startsWith("/skills") ||
                              path.startsWith("/profile") ||
                              path.startsWith("/requests") ||
                              path.startsWith("/search");

        // Auth pages — redirect away if already logged in
        boolean isAuthPage = path.equals("/login") || path.equals("/register");

        if (isProtected && !loggedIn) {
            response.sendRedirect(contextPath + "/login?unauthorized=true");
            return;
        }

        if (isAuthPage && loggedIn) {
            response.sendRedirect(contextPath + "/dashboard");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
