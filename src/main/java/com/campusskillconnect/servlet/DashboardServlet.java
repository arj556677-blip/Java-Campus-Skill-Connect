package com.campusskillconnect.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.campusskillconnect.dao.SkillDAO;
import com.campusskillconnect.dao.SkillRequestDAO;
import com.campusskillconnect.exception.AppException;
import com.campusskillconnect.model.Skill;
import com.campusskillconnect.model.SkillRequest;
import com.campusskillconnect.model.User;

/**
 * DashboardServlet — User main overview page after authentication.
 *
 * Route: /dashboard
 * Displays user profile summary, user's listed skills, and pending incoming collaboration requests.
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final SkillDAO skillDAO = new SkillDAO();
    private final SkillRequestDAO requestDAO = new SkillRequestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<Skill> userSkills = skillDAO.getSkillsByUserId(user.getId());
            List<SkillRequest> receivedRequests = requestDAO.getReceivedRequests(user.getId());
            List<SkillRequest> sentRequests = requestDAO.getSentRequests(user.getId());

            long pendingCount = receivedRequests.stream()
                    .filter(r -> "PENDING".equalsIgnoreCase(r.getStatus().name()))
                    .count();

            request.setAttribute("userSkills", userSkills);
            request.setAttribute("receivedRequests", receivedRequests);
            request.setAttribute("sentRequests", sentRequests);
            request.setAttribute("pendingCount", pendingCount);

            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);

        } catch (AppException e) {
            request.setAttribute("errorMessage", "Error loading dashboard data: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
        }
    }
}
