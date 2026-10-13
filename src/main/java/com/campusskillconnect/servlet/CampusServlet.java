package com.campusskillconnect.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.campusskillconnect.dao.InstitutionDAO;
import com.campusskillconnect.model.Campus;

/**
 * CampusServlet — REST-like API endpoint for AJAX campus fetching.
 *
 * Route: /api/campuses?institutionId=X
 * Response: JSON array of campuses for the given institution ID.
 *
 * HOW IT WORKS:
 * When the user selects an Institution in the registration dropdown,
 * JavaScript calls this endpoint via fetch() to populate the
 * Campus dropdown dynamically without refreshing the page!
 */
@WebServlet("/api/campuses")
public class CampusServlet extends HttpServlet {

    private final InstitutionDAO institutionDAO = new InstitutionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String instIdParam = request.getParameter("institutionId");

        if (instIdParam == null || instIdParam.trim().isEmpty()) {
            out.print("[]");
            return;
        }

        try {
            int institutionId = Integer.parseInt(instIdParam);
            List<Campus> campuses = institutionDAO.getCampusesByInstitutionId(institutionId);

            // Manual JSON generation to avoid heavy dependencies
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < campuses.size(); i++) {
                Campus c = campuses.get(i);
                json.append(String.format("{\"id\":%d,\"name\":\"%s\",\"city\":\"%s\"}",
                        c.getId(),
                        escapeJson(c.getName()),
                        escapeJson(c.getAddress())));
                if (i < campuses.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");

            out.print(json.toString());

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"Invalid institution ID\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + escapeJson(e.getMessage()) + "\"}");
        }
    }

    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r");
    }
}
