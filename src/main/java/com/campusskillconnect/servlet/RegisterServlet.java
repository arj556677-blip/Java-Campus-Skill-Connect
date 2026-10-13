package com.campusskillconnect.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.campusskillconnect.dao.InstitutionDAO;
import com.campusskillconnect.dao.UserDAO;
import com.campusskillconnect.exception.AppException;
import com.campusskillconnect.model.Institution;
import com.campusskillconnect.model.User;
import com.campusskillconnect.util.PasswordUtil;

/**
 * RegisterServlet — Handles Student Registration.
 *
 * GET  /register → Renders registration form with institution choices
 * POST /register → Validates form inputs, hashes password, saves User to DB,
 *                  logs user in, and redirects to dashboard.
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final InstitutionDAO institutionDAO = new InstitutionDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // If user is already logged in, redirect to dashboard
        if (request.getSession().getAttribute("loggedInUser") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        try {
            List<Institution> institutions = institutionDAO.getAllInstitutions();
            request.setAttribute("institutions", institutions);
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        } catch (AppException e) {
            request.setAttribute("errorMessage", "Failed to load institutions: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String institutionIdStr = request.getParameter("institutionId");
        String campusIdStr = request.getParameter("campusId");
        String course = request.getParameter("course");
        String yearOfStudyStr = request.getParameter("yearOfStudy");
        String bio = request.getParameter("bio");

        // Preserve form inputs for re-rendering on validation failure
        request.setAttribute("email", email);
        request.setAttribute("firstName", firstName);
        request.setAttribute("lastName", lastName);
        request.setAttribute("course", course);
        request.setAttribute("yearOfStudy", yearOfStudyStr);
        request.setAttribute("bio", bio);

        // Validation
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            institutionIdStr == null || campusIdStr == null) {

            forwardWithError(request, response, "Please fill in all required fields.");
            return;
        }

        if (!password.equals(confirmPassword)) {
            forwardWithError(request, response, "Passwords do not match.");
            return;
        }

        if (password.length() < 6) {
            forwardWithError(request, response, "Password must be at least 6 characters long.");
            return;
        }

        try {
            int institutionId = Integer.parseInt(institutionIdStr);
            int campusId = Integer.parseInt(campusIdStr);
            int yearOfStudy = yearOfStudyStr != null && !yearOfStudyStr.isEmpty() ? Integer.parseInt(yearOfStudyStr) : 1;

            // Hash password securely with jBCrypt
            String passwordHash = PasswordUtil.hashPassword(password);

            // Construct User object
            User newUser = new User();
            newUser.setEmail(email.trim().toLowerCase());
            newUser.setPasswordHash(passwordHash);
            newUser.setFirstName(firstName.trim());
            newUser.setLastName(lastName.trim());
            newUser.setInstitutionId(institutionId);
            newUser.setCampusId(campusId);
            newUser.setCourse(course != null ? course.trim() : "");
            newUser.setYearOfStudy(yearOfStudy);
            newUser.setBio(bio != null ? bio.trim() : "");

            // Save user to MySQL
            int userId = userDAO.insertUser(newUser);

            // Retrieve full user record with institution/campus names
            User loggedUser = userDAO.findById(userId);

            // Set session
            request.getSession().setAttribute("loggedInUser", loggedUser);

            // Redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/dashboard");

        } catch (AppException e) {
            forwardWithError(request, response, e.getMessage());
        } catch (NumberFormatException e) {
            forwardWithError(request, response, "Invalid institution or campus selection.");
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String error)
            throws ServletException, IOException {
        try {
            List<Institution> institutions = institutionDAO.getAllInstitutions();
            request.setAttribute("institutions", institutions);
        } catch (AppException ignored) {}

        request.setAttribute("errorMessage", error);
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }
}
