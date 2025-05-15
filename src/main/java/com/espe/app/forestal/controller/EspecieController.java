package com.espe.app.forestal.controller;

import com.espe.app.forestal.dao.EspecieDao;
import com.espe.app.forestal.model.EspecieArbol;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "EspecieController", urlPatterns = {"/Especie"})
public class EspecieController extends HttpServlet {
    private final EspecieDao especieDao = new EspecieDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String option = req.getParameter("option");
        if (option == null) option = "getAll";

        switch (option) {
            case "new":
                // formulario en blanco
                req.getRequestDispatcher("/WEB-INF/views/Especie.jsp")
                   .forward(req, resp);
                break;

            case "update":
                Integer idUpd = Integer.parseInt(req.getParameter("id"));
                EspecieArbol e = especieDao.findById(idUpd);
                req.setAttribute("especie", e);
                req.getRequestDispatcher("/WEB-INF/views/formEspecie.jsp")
                   .forward(req, resp);
                break;

            case "delete":
                Integer idDel = Integer.parseInt(req.getParameter("id"));
                especieDao.delete(idDel);
                resp.sendRedirect(req.getContextPath() + "/Especie");
                break;

            default:  // getAll
                List<EspecieArbol> list = especieDao.findAll();
                req.setAttribute("especies", list);
                req.getRequestDispatcher("/WEB-INF/views/Especie.jsp")
                   .forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idParam = req.getParameter("especieId");
        Integer id = (idParam == null || idParam.isEmpty())
                     ? null
                     : Integer.parseInt(idParam);

        EspecieArbol e = new EspecieArbol();
        if (id != null) e.setEspecieId(id);

        e.setNombreCientifico(req.getParameter("nombreCientifico"));
        e.setNombreComun(req.getParameter("nombreComun"));
        e.setFamilia(req.getParameter("familia"));
        e.setEstadoConservacion(
            com.espe.app.forestal.model.EstadoConservacion.valueOf(req.getParameter("estadoConservacion").toUpperCase().replace(' ', '_'))
        );
        e.setDescripcion(req.getParameter("descripcion"));
        e.setImagenUrl(req.getParameter("imagenUrl"));

        if (id == null) {
            especieDao.save(e);
        } else {
            especieDao.update(e);
        }
        resp.sendRedirect(req.getContextPath() + "/Especie");
    }
}
