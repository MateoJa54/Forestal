package com.espe.app.forestal.controller;

import com.espe.app.forestal.model.ZonaEspecie;
import com.espe.app.forestal.service.ZonaEspecieService;
import com.espe.app.forestal.service.ZonaService;
import com.espe.app.forestal.service.EspecieService;
import com.espe.app.forestal.model.EspecieArbol;
import com.espe.app.forestal.model.EspecieZonaDetalle;
import com.espe.app.forestal.model.ZonaForestal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "ZonaEspecieController", urlPatterns = {"/ZonaEspecie"})
public class ZonaEspecieController extends HttpServlet {
    private final ZonaEspecieService zeService = new ZonaEspecieService();
    private final ZonaService zonaService = new ZonaService();
    private final EspecieService especieService = new EspecieService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            int zonaId = Integer.parseInt(req.getParameter("zonaId"));
            int espId = Integer.parseInt(req.getParameter("especieId"));
            zeService.delete(zonaId, espId);
            resp.sendRedirect(req.getContextPath() + "/ZonaEspecie?zonaId=" + zonaId);
            return;
        }

        String zonaIdParam = req.getParameter("zonaId");
        Integer zonaId = (zonaIdParam == null) ? null : Integer.parseInt(zonaIdParam);

        // Listas para select
        List<ZonaForestal> allZonas = zonaService.findAll();
        List<EspecieArbol> allEspecies = especieService.findAll();
        req.setAttribute("allZonas", allZonas);
        req.setAttribute("allEspecies", allEspecies);

        // Asociaciones o detalle
        if (zonaId != null) {
            req.setAttribute("selectedZonaId", zonaId);
            // Para mostrar entidades completas
            List<ZonaEspecie> rels = zeService.findByZona(zonaId);
            req.setAttribute("zonaEspecies", rels);
            // Para mostrar detalle DTO
            List<EspecieZonaDetalle> detalle = zeService.getDetalleByZona(zonaId);
            req.setAttribute("detalle", detalle);
        }

        // Forward a la JSP
        req.getRequestDispatcher("/WEB-INF/views/zonaEspecie.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int zonaId = Integer.parseInt(req.getParameter("zonaId"));
        int especieId = Integer.parseInt(req.getParameter("especieId"));
        BigDecimal densidad = new BigDecimal(req.getParameter("densidad"));
        zeService.save(zonaId, especieId, densidad);
        resp.sendRedirect(req.getContextPath() + "/ZonaEspecie?zonaId=" + zonaId);
    }
}