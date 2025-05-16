package com.espe.app.forestal.controller;

import com.espe.app.forestal.dao.ZonaDao;
import com.espe.app.forestal.dao.EspecieDao;
import com.espe.app.forestal.dao.ZonaEspecieDao;
import com.espe.app.forestal.model.ZonaEspecie;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name="ZonaEspecieController", urlPatterns={"/ZonaEspecie"})
public class ZonaEspecieController extends HttpServlet {
    private final ZonaEspecieDao zeDao = new ZonaEspecieDao();
    private final ZonaDao zonaDao        = new ZonaDao();
    private final EspecieDao espDao      = new EspecieDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Parámetro opcional para filtrar por zona
        String action = req.getParameter("action");
if ("delete".equals(action)) {
    int zonaId = Integer.parseInt(req.getParameter("zonaId"));
    int espId  = Integer.parseInt(req.getParameter("especieId"));
    zeDao.delete(zonaId, espId);
    resp.sendRedirect(req.getContextPath() + "/ZonaEspecie?zonaId=" + zonaId);
    return;
}

        
        String zonaIdParam = req.getParameter("zonaId");
        Integer zonaId = (zonaIdParam == null) 
            ? null 
            : Integer.parseInt(zonaIdParam);

        // Listas para select
        req.setAttribute("allZonas", zonaDao.findAll());
        req.setAttribute("allEspecies", espDao.findAll());

        // Si vino zonaId, cargo las asociaciones
        if (zonaId != null) {
            req.setAttribute("selectedZonaId", zonaId);
            List<ZonaEspecie> rels = zeDao.findEspeciesByZona(zonaId);
            req.setAttribute("zonaEspecies", rels);
        }

        // Forward a la JSP
        req.getRequestDispatcher("/WEB-INF/views/zonaEspecie.jsp")
           .forward(req, resp);
        
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Agregar asociación
        int zonaId    = Integer.parseInt(req.getParameter("zonaId"));
        int especieId= Integer.parseInt(req.getParameter("especieId"));
        BigDecimal densidad = new BigDecimal(req.getParameter("densidad"));
        zeDao.save(zonaId, especieId, densidad);

        // Redirijo al GET con zonaId para recargar la tabla
        resp.sendRedirect(req.getContextPath() + "/ZonaEspecie?zonaId=" + zonaId);
    }
}
