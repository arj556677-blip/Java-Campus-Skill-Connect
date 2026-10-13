package com.campusskillconnect.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.campusskillconnect.dao.SkillDAO;
import com.campusskillconnect.dao.UserDAO;
import com.campusskillconnect.exception.AppException;
import com.campusskillconnect.model.Skill;
import com.campusskillconnect.model.User;

/**
 * SearchServlet — Skill-based student search.
 *
 * GET /search            → Show blank search form
 * GET /search?q=java     → Show students who have skills matching "java"
 * GET /search?userId=5   → View another student's public skill profile
 */
@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        String query = request.getParameter("q");
        String viewUserId = request.getParameter("userId");

        try {
            // View a specific student's public profile
            if (viewUserId != null && !viewUserId.trim().isEmpty()) {
                int targetId = Integer.parseInt(viewUserId);
                if (targetId == loggedInUser.getId()) {
                    // Redirect to own profile page
                    response.sendRedirect(request.getContextPath() + "/profile");
                    return;
                }
                User targetUser = userDAO.findById(targetId);
                if (targetUser != null) {
                    List<Skill> targetSkills = skillDAO.getSkillsByUserId(targetId);
                    request.setAttribute("targetUser", targetUser);
                    request.setAttribute("targetSkills", targetSkills);
                }
                request.getRequestDispatcher("/WEB-INF/views/search.jsp").forward(request, response);
                return;
            }

            // Keyword search
            if (query != null && !query.trim().isEmpty()) {
                List<User> results = userDAO.searchBySkill(query.trim());
                // Exclude the logged-in user from results
                results.removeIf(u -> u.getId() == loggedInUser.getId());
                request.setAttribute("searchResults", results);
                request.setAttribute("query", query.trim());
            }

        } catch (AppException | NumberFormatException e) {
            request.setAttribute("errorMessage", "Search failed: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/views/search.jsp").forward(request, response);
    }
}
