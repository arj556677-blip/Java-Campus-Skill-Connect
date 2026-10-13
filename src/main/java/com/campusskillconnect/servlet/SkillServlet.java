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
import com.campusskillconnect.exception.AppException;
import com.campusskillconnect.model.ProficiencyLevel;
import com.campusskillconnect.model.Skill;
import com.campusskillconnect.model.User;

/**
 * SkillServlet — Manages a student's skill portfolio.
 *
 * GET  /skills          → Show all skills for logged-in user
 * POST /skills?action=add    → Add a new skill
 * POST /skills?action=edit   → Update an existing skill
 * POST /skills?action=delete → Delete a skill
 */
@WebServlet("/skills")
public class SkillServlet extends HttpServlet {

    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        try {
            List<Skill> skills = skillDAO.getSkillsByUserId(loggedInUser.getId());
            request.setAttribute("userSkills", skills);
            request.setAttribute("proficiencyLevels", ProficiencyLevel.values());

            // If editing, load the skill being edited
            String editIdParam = request.getParameter("editId");
            if (editIdParam != null) {
                int editId = Integer.parseInt(editIdParam);
                Skill editSkill = skillDAO.findById(editId);
                // Security: only allow editing own skills
                if (editSkill != null && editSkill.getUserId() == loggedInUser.getId()) {
                    request.setAttribute("editSkill", editSkill);
                }
            }

        } catch (AppException e) {
            request.setAttribute("errorMessage", "Could not load skills: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/views/skills.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        String action = request.getParameter("action");
        String contextPath = request.getContextPath();

        try {
            if ("add".equals(action)) {
                handleAdd(request, loggedInUser);
                response.sendRedirect(contextPath + "/skills?success=added");

            } else if ("edit".equals(action)) {
                handleEdit(request, loggedInUser);
                response.sendRedirect(contextPath + "/skills?success=updated");

            } else if ("delete".equals(action)) {
                handleDelete(request, loggedInUser);
                response.sendRedirect(contextPath + "/skills?success=deleted");

            } else {
                response.sendRedirect(contextPath + "/skills");
            }

        } catch (AppException e) {
            request.setAttribute("errorMessage", e.getMessage());
            doGet(request, response); // Re-render with error
        } catch (NumberFormatException e) {
            response.sendRedirect(contextPath + "/skills");
        }
    }

    private void handleAdd(HttpServletRequest request, User user) throws AppException {
        String skillName = request.getParameter("skillName");
        String levelStr  = request.getParameter("proficiencyLevel");
        String desc      = request.getParameter("description");

        if (skillName == null || skillName.trim().isEmpty()) {
            throw new AppException("Skill name is required.");
        }

        Skill skill = new Skill(user.getId(), skillName.trim(),
                ProficiencyLevel.fromString(levelStr), desc != null ? desc.trim() : "");
        skillDAO.addSkill(skill);
    }

    private void handleEdit(HttpServletRequest request, User user) throws AppException {
        int skillId      = Integer.parseInt(request.getParameter("skillId"));
        String skillName = request.getParameter("skillName");
        String levelStr  = request.getParameter("proficiencyLevel");
        String desc      = request.getParameter("description");

        // Security: verify the skill belongs to this user
        Skill existing = skillDAO.findById(skillId);
        if (existing == null || existing.getUserId() != user.getId()) {
            throw new AppException("Skill not found or access denied.");
        }

        existing.setSkillName(skillName.trim());
        existing.setProficiencyLevelFromString(levelStr);
        existing.setDescription(desc != null ? desc.trim() : "");
        skillDAO.updateSkill(existing);
    }

    private void handleDelete(HttpServletRequest request, User user) throws AppException {
        int skillId = Integer.parseInt(request.getParameter("skillId"));

        // Security: verify the skill belongs to this user
        Skill existing = skillDAO.findById(skillId);
        if (existing == null || existing.getUserId() != user.getId()) {
            throw new AppException("Skill not found or access denied.");
        }

        skillDAO.deleteSkill(skillId);
    }
}
