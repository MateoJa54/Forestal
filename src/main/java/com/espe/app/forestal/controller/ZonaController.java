package com.espe.app.forestal.controller;


import com.espe.app.forestal.dao.ZonaDao;
import com.espe.app.forestal.model.ZonaForestal;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ZonaController", urlPatterns = {"/Zona"})
public class ZonaController extends HttpServlet {
    private final ZonaDao zonaDao = new ZonaDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String option = req.getParameter("option");
        if (option == null) option = "getAll";

        switch (option) {
            case "new":
                // formulario en blanco
                req.getRequestDispatcher("/WEB-INF/views/formZona.jsp").forward(req, resp);
                break;

            case "update":
                Integer idUpd = Integer.parseInt(req.getParameter("id"));
                ZonaForestal z = zonaDao.findById(idUpd);
                req.setAttribute("zona", z);
                req.getRequestDispatcher("/WEB-INF/views/formZona.jsp").forward(req, resp);
                break;

            case "delete":
                Integer idDel = Integer.parseInt(req.getParameter("id"));
                zonaDao.delete(idDel);
                // tras eliminar, recarga la lista
                resp.sendRedirect("Zona");
                break;

            default:  // "getAll"
                List<ZonaForestal> list = zonaDao.findAll();
                req.setAttribute("zonas", list);
                req.getRequestDispatcher("/WEB-INF/views/zonas.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idParam = req.getParameter("zonaId");
        Integer id = (idParam == null || idParam.isEmpty()) ? null : Integer.parseInt(idParam);

        String nombre        = req.getParameter("nombre");
        String ubicacion     = req.getParameter("ubicacion");
        String areaStr       = req.getParameter("areaHectareas");
        String tipoVeg       = req.getParameter("tipoVegetacion");
        String coordenadas   = req.getParameter("coordenadas");
        String fechaRegStr   = req.getParameter("fechaRegistro");

        ZonaForestal zona = new ZonaForestal();
        if (id != null) zona.setZonaId(id);
        zona.setNombre(nombre);
        zona.setUbicacion(ubicacion);
        zona.setAreaHectareas(new java.math.BigDecimal(areaStr));
        zona.setTipoVegetacion(tipoVeg);
        zona.setCoordenadas(coordenadas);
        zona.setFechaRegistro(java.time.LocalDate.parse(fechaRegStr));

        if (id == null) {
            zonaDao.save(zona);
        } else {
            zonaDao.update(zona);
        }
        // redirige al servlet para refrescar la lista
        resp.sendRedirect("Zona");
    }
}
