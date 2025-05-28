package com.espe.app.forestal.controller;

import com.espe.app.forestal.model.EspecieArbol;
import com.espe.app.forestal.service.EspecieService;
import com.espe.app.validator.EspecieValidator;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "EspecieController", urlPatterns = {"/EspecieAdmin"})
public class EspecieController extends HttpServlet {
    private final EspecieService especieService = new EspecieService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String option = req.getParameter("option");
        if (option == null) option = "getAll";

        switch (option) {
            case "new":
                req.getRequestDispatcher("/WEB-INF/views/Admin/Especie.jsp").forward(req, resp);
                break;
            case "update":
                int idUpd = Integer.parseInt(req.getParameter("id"));
                EspecieArbol e = especieService.findById(idUpd);
                req.setAttribute("especie", e);
                req.getRequestDispatcher("/WEB-INF/views/Admin/Especie.jsp").forward(req, resp);
                break;
            case "delete":
                int idDel = Integer.parseInt(req.getParameter("id"));
                especieService.delete(idDel);
                resp.sendRedirect(req.getContextPath() + "/EspecieAdmin");
                break;
            default:  // getAll
                List<EspecieArbol> list = especieService.findAll();
                req.setAttribute("especies", list);
                req.getRequestDispatcher("/WEB-INF/views/Admin/Especie.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idParam = req.getParameter("especieId");
        Integer id = (idParam == null || idParam.isEmpty()) ? null : Integer.parseInt(idParam);

        EspecieArbol e = new EspecieArbol();
        if (id != null) e.setEspecieId(id);
        e.setNombreCientifico(req.getParameter("nombreCientifico"));
        e.setNombreComun(req.getParameter("nombreComun"));
        e.setFamilia(req.getParameter("familia"));
        e.setEstadoConservacion(
            com.espe.app.forestal.model.EstadoConservacion.valueOf(
                req.getParameter("estadoConservacion").toUpperCase().replace(' ', '_'))
        );
        e.setDescripcion(req.getParameter("descripcion"));
        e.setImagenUrl(req.getParameter("imagenUrl"));

        EspecieValidator validator = new EspecieValidator();
        List<String> errores = validator.validar(e);
        if (!errores.isEmpty()) {
            req.setAttribute("errores", errores);
            req.setAttribute("especie", e);
            req.getRequestDispatcher("/WEB-INF/views/Admin/Especie.jsp").forward(req, resp);
            return;
        }

        if (id == null) {
            especieService.save(e);
        } else {
            especieService.update(e);
        }
        resp.sendRedirect(req.getContextPath() + "/EspecieAdmin");
    }
}