/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.espe.app.forestal.controller;

import com.espe.app.forestal.model.EspecieArbol;
import com.espe.app.forestal.service.EspecieService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "EspecieUser", urlPatterns = {"/EspecieUser"})
public class EspecieUserController extends HttpServlet {
    private final EspecieService especieService = new EspecieService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Verificar sesión
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect(req.getContextPath() + "/Sesion.jsp");
            return;
        }

        // Obtener todas las especies
        List<EspecieArbol> especies = especieService.findAll();
        req.setAttribute("especies", especies);

        // Despachar a la vista de usuario
        req.getRequestDispatcher("/WEB-INF/views/User/EspecieUser.jsp")
           .forward(req, resp);
    }
}
