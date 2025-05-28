
package com.espe.app.forestal.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "UserController", urlPatterns = {"/User"})
public class UserController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect(req.getContextPath() + "/Sesion.jsp");
            return;
        }

        // Parámetro opcional para elegir la vista: zona, especie o actividad
        String page = req.getParameter("page");
        if (page == null) {
            page = "Zona";
        }

        String jsp;
        switch (page) {
            case "Especie":
                jsp = "/WEB-INF/views/User/EspecieUser.jsp";
                break;
            case "Actividad":
                jsp = "/WEB-INF/views/User/ActividadUser.jsp";
                break;
            case "Zona":
            default:
                jsp = "/WEB-INF/views/User/ZonaUser.jsp";
                break;
        }

        req.getRequestDispatcher(jsp).forward(req, resp);
    }
}
