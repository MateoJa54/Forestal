// src/main/java/com/espe/app/forestal/controller/ActividadUserController.java
package com.espe.app.forestal.controller;

import com.espe.app.forestal.model.ActividadConservacion;
import com.espe.app.forestal.service.ActividadService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ActividadUser", urlPatterns = {"/ActividadUser"})
public class ActividadUserController extends HttpServlet {
    private final ActividadService actividadService = new ActividadService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // 1) Verificar que haya sesión
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect(req.getContextPath() + "/Sesion.jsp");
            return;
        }

        // 2) Obtener todas las actividades (cada una trae su zona asociada)
        List<ActividadConservacion> actividades = actividadService.findAll();
        req.setAttribute("actividades", actividades);

        // 3) Despachar a la vista de usuario
        req.getRequestDispatcher("/WEB-INF/views/User/ActividadUser.jsp")
           .forward(req, resp);
    }
}
