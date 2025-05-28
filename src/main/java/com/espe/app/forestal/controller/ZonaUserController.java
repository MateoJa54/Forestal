/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.espe.app.forestal.controller;
import com.espe.app.forestal.model.EspecieZonaDetalle;
import com.espe.app.forestal.model.ZonaForestal;
import com.espe.app.forestal.service.ZonaEspecieService;
import com.espe.app.forestal.service.ZonaService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ZonaUser", urlPatterns = {"/ZonaUser"})
public class ZonaUserController extends HttpServlet {

    private final ZonaService zonaService = new ZonaService();
    private final ZonaEspecieService zeService = new ZonaEspecieService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            // No autenticado, redirige a login
            resp.sendRedirect(req.getContextPath() + "/Sesion.jsp");
            return;
        }

        String option = req.getParameter("option");
        if ("listarEspeciesZona".equals(option)) {
            // carga detalle de especie para modal
            int zonaId = Integer.parseInt(req.getParameter("zonaId"));
            List<EspecieZonaDetalle> especiesZona =
                zeService.getDetalleByZona(zonaId);
            req.setAttribute("especiesZona", especiesZona);
        }

        // Siempre carga la lista de zonas
        List<ZonaForestal> zonas = zonaService.findAll();
        req.setAttribute("zonas", zonas);

        // Despacha a la vista de usuario
        req.getRequestDispatcher("/WEB-INF/views/User/ZonaUser.jsp")
           .forward(req, resp);
    }
}
