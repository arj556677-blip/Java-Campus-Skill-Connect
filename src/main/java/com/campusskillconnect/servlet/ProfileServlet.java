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

/**
 * ProfileServlet — View and edit the logged-in student's profile.
 *
 * GET  /profile       → Show the current profile (pre-filled form)
 * POST /profile       → Save updated profile information
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // The logged-in user is already in the session; just render the form
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        String firstName  = request.getParameter("firstName");
        String lastName   = request.getParameter("lastName");
        String course     = request.getParameter("course");
        String yearStr    = request.getParameter("yearOfStudy");
        String bio        = request.getParameter("bio");

        // Basic validation
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName  == null || lastName.trim().isEmpty()) {
            request.setAttribute("errorMessage", "First name and last name are required.");
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        try {
            int yearOfStudy = 1;
            if (yearStr != null && !yearStr.trim().isEmpty()) {
                yearOfStudy = Integer.parseInt(yearStr);
            }

            // Update the user object
            loggedInUser.setFirstName(firstName.trim());
            loggedInUser.setLastName(lastName.trim());
            loggedInUser.setCourse(course != null ? course.trim() : "");
            loggedInUser.setYearOfStudy(yearOfStudy);
            loggedInUser.setBio(bio != null ? bio.trim() : "");

            userDAO.updateProfile(loggedInUser);

            // Refresh the session with updated user data
            User refreshedUser = userDAO.findById(loggedInUser.getId());
            session.setAttribute("loggedInUser", refreshedUser);

            response.sendRedirect(request.getContextPath() + "/profile?success=true");

        } catch (AppException | NumberFormatException e) {
            request.setAttribute("errorMessage", "Failed to update profile: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
        }
    }
}
