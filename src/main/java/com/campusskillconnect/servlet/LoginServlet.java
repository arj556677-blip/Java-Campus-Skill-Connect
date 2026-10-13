package com.campusskillconnect.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.campusskillconnect.dao.UserDAO;
import com.campusskillconnect.exception.AppException;
import com.campusskillconnect.model.User;
import com.campusskillconnect.util.PasswordUtil;

/**
 * LoginServlet — Handles Student Login and Authentication.
 *
 * GET  /login → Renders login form
 * POST /login → Verifies credentials, sets session, and redirects to dashboard.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // AuthFilter handles redirect if already logged in
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        request.setAttribute("email", email);

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please enter both email and password.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }

        try {
            User user = userDAO.findByEmail(email.trim().toLowerCase());

            if (user == null) {
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }

            // Verify BCrypt password hash
            boolean valid = PasswordUtil.verifyPassword(password, user.getPasswordHash());

            if (!valid) {
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }

            // Fetch full user details with Institution & Campus names
            User fullUser = userDAO.findById(user.getId());

            // Bind user to HTTP Session
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", fullUser);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes session timeout

            // Redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/dashboard");

        } catch (AppException e) {
            request.setAttribute("errorMessage", "Authentication failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
}
