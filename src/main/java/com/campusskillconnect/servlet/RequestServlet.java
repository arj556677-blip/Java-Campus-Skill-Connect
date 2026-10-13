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
import com.campusskillconnect.dao.SkillRequestDAO;
import com.campusskillconnect.exception.AppException;
import com.campusskillconnect.model.Skill;
import com.campusskillconnect.model.SkillRequest;
import com.campusskillconnect.model.User;

/**
 * RequestServlet — Manages collaboration requests between students.
 *
 * GET  /requests              → Show inbox (received) and sent requests
 * POST /requests?action=send  → Send a new collaboration request
 * POST /requests?action=accept→ Accept a received request
 * POST /requests?action=reject→ Reject a received request
 */
@WebServlet("/requests")
public class RequestServlet extends HttpServlet {

    private final SkillRequestDAO requestDAO = new SkillRequestDAO();
    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        try {
            List<SkillRequest> receivedRequests = requestDAO.getReceivedRequests(loggedInUser.getId());
            List<SkillRequest> sentRequests     = requestDAO.getSentRequests(loggedInUser.getId());

            request.setAttribute("receivedRequests", receivedRequests);
            request.setAttribute("sentRequests", sentRequests);

            long pendingCount = receivedRequests.stream()
                    .filter(r -> r.getStatus().name().equals("PENDING"))
                    .count();
            request.setAttribute("pendingCount", pendingCount);

        } catch (AppException e) {
            request.setAttribute("errorMessage", "Could not load requests: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/views/requests.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        String action = request.getParameter("action");
        String contextPath = request.getContextPath();

        try {
            switch (action != null ? action : "") {
                case "send" -> {
                    handleSend(request, loggedInUser);
                    response.sendRedirect(contextPath + "/requests?success=sent");
                }
                case "accept" -> {
                    handleUpdateStatus(request, loggedInUser, "ACCEPTED");
                    response.sendRedirect(contextPath + "/requests?success=accepted");
                }
                case "reject" -> {
                    handleUpdateStatus(request, loggedInUser, "REJECTED");
                    response.sendRedirect(contextPath + "/requests?success=rejected");
                }
                default -> response.sendRedirect(contextPath + "/requests");
            }
        } catch (AppException | NumberFormatException e) {
            request.setAttribute("errorMessage", e.getMessage());
            doGet(request, response);
        }
    }

    private void handleSend(HttpServletRequest request, User sender) throws AppException {
        int toUserId  = Integer.parseInt(request.getParameter("toUserId"));
        int skillId   = Integer.parseInt(request.getParameter("skillId"));
        String message = request.getParameter("message");

        if (toUserId == sender.getId()) {
            throw new AppException("You cannot send a request to yourself.");
        }

        // Verify the skill belongs to the target user
        Skill targetSkill = skillDAO.findById(skillId);
        if (targetSkill == null || targetSkill.getUserId() != toUserId) {
            throw new AppException("Invalid skill selected.");
        }

        SkillRequest sr = new SkillRequest(sender.getId(), toUserId, skillId,
                message != null ? message.trim() : "");
        requestDAO.sendRequest(sr);
    }

    private void handleUpdateStatus(HttpServletRequest request, User loggedInUser, String newStatus)
            throws AppException {
        int requestId = Integer.parseInt(request.getParameter("requestId"));

        SkillRequest existing = requestDAO.findById(requestId);
        if (existing == null || existing.getToUserId() != loggedInUser.getId()) {
            throw new AppException("Request not found or access denied.");
        }

        requestDAO.updateStatus(requestId, newStatus);
    }
}
