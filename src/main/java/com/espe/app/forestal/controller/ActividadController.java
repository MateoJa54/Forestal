package com.espe.app.forestal.controller;

import com.espe.app.forestal.dao.ActividadDao;
import com.espe.app.forestal.dao.ZonaDao;
import com.espe.app.forestal.model.ActividadConservacion;
import com.espe.app.forestal.model.EstadoActividad;
import com.espe.app.forestal.model.ZonaForestal;
import com.espe.app.validator.ActividadValidator;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Map;

@WebServlet(name = "ActividadController", urlPatterns = {"/Actividad"})
public class ActividadController extends HttpServlet {

    private final ActividadDao actividadDao = new ActividadDao();
    private final ZonaDao zonaDao = new ZonaDao(); // Para obtener las zonas
     private final ActividadValidator actividadValidator = new ActividadValidator();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String option = req.getParameter("option");
        if (option == null) {
            option = "getAll";
        }

        switch (option) {
            case "new":
                // Cargar las zonas para el formulario
                List<ZonaForestal> zonas = zonaDao.findAll();
                req.setAttribute("zonas", zonas);
                req.getRequestDispatcher("/WEB-INF/views/Actividad.jsp")
                        .forward(req, resp);
                break;

            case "update":
                Integer idUpd = Integer.parseInt(req.getParameter("id"));
                ActividadConservacion actividad = actividadDao.findById(idUpd);
                List<ZonaForestal> zonasUpdate = zonaDao.findAll();
                req.setAttribute("actividad", actividad);
                req.setAttribute("zonas", zonasUpdate);
                req.getRequestDispatcher("/WEB-INF/views/Actividad.jsp")
                        .forward(req, resp);
                break;

            case "delete":
                Integer idDel = Integer.parseInt(req.getParameter("id"));
                actividadDao.delete(idDel);
                resp.sendRedirect(req.getContextPath() + "/Actividad");
                break;

            default:  // getAll
                List<ActividadConservacion> list = actividadDao.findAll();
                zonas = zonaDao.findAll();
                req.setAttribute("actividades", list);
                req.setAttribute("zonas", zonas);
                req.getRequestDispatcher("/WEB-INF/views/Actividad.jsp")
                        .forward(req, resp);
        }
    }

   @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        String idParam = req.getParameter("actividadId");
        Integer id = (idParam == null || idParam.isEmpty()) ? null : Integer.parseInt(idParam);

        ActividadConservacion actividad = new ActividadConservacion();
        if (id != null) {
            actividad.setActividadId(id);
        }

        actividad.setNombre(req.getParameter("nombre"));
        actividad.setDescripcion(req.getParameter("descripcion"));
        actividad.setFechaInicio(LocalDate.parse(req.getParameter("fechaInicio")));

        String fechaFinParam = req.getParameter("fechaFin");
        if (fechaFinParam != null && !fechaFinParam.isEmpty()) {
            actividad.setFechaFin(LocalDate.parse(fechaFinParam));
        }

        actividad.setPresupuesto(new BigDecimal(req.getParameter("presupuesto")));
        actividad.setEstado(EstadoActividad.valueOf(req.getParameter("estado").toUpperCase()));

        Integer zonaId = Integer.parseInt(req.getParameter("zonaId"));
        ZonaForestal zona = zonaDao.findById(zonaId);
        if (zona == null) {
            throw new ServletException("Zona con id " + zonaId + " no existe.");
        }
        actividad.setZona(zona);

        // Validación
        List<String> errores = actividadValidator.validate(actividad);

        if (errores.isEmpty()) {
            if (id == null) {
                actividadDao.save(actividad);
            } else {
                actividadDao.update(actividad);
            }
            resp.sendRedirect(req.getContextPath() + "/Actividad");
        } else {
            req.setAttribute("errores", errores);
            req.setAttribute("actividad", actividad);
            req.setAttribute("zonas", zonaDao.findAll());

            // Cargar la lista de actividades de nuevo para que la tabla se muestre
            List<ActividadConservacion> list = actividadDao.findAll();
            req.setAttribute("actividades", list);

            req.getRequestDispatcher("/WEB-INF/views/Actividad.jsp").forward(req, resp);
        }
    }
}