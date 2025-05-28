package com.espe.app.forestal.controller;


import com.espe.app.forestal.model.EspecieZonaDetalle;
import com.espe.app.forestal.model.ZonaForestal;
import com.espe.app.forestal.service.ZonaService;
import com.espe.app.validator.ZonaValidator;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ZonaController", urlPatterns = {"/ZonaAdmin"})
public class ZonaController extends HttpServlet {
    private final ZonaService zonaService = new ZonaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String option = req.getParameter("option");
        if (option == null) option = "getAll";

        switch (option) {
            case "new":
                req.getRequestDispatcher("/WEB-INF/views/Admin/formZona.jsp").forward(req, resp);
                break;
            case "update":
                int idUpd = Integer.parseInt(req.getParameter("id"));
                ZonaForestal z = zonaService.findById(idUpd);
                req.setAttribute("zona", z);
                req.getRequestDispatcher("/WEB-INF/views/Admin/formZona.jsp").forward(req, resp);
                break;
            case "delete":
                int idDel = Integer.parseInt(req.getParameter("id"));
                zonaService.delete(idDel);
                resp.sendRedirect(req.getContextPath() + "/ZonaAdmin");
                break;
            case "listarEspeciesZona":
                int zonaIdEspecies = Integer.parseInt(req.getParameter("zonaId"));
                List<EspecieZonaDetalle> especiesZona =
                    zonaService.findEspeciesByZonaId(zonaIdEspecies);
                req.setAttribute("especiesZona", especiesZona);
                List<ZonaForestal> todas = zonaService.findAll();
                req.setAttribute("zonas", todas);
                req.getRequestDispatcher("/WEB-INF/views/Admin/zonas.jsp").forward(req, resp);
                return;
            default:
                List<ZonaForestal> list = zonaService.findAll();
                req.setAttribute("zonas", list);
                req.getRequestDispatcher("/WEB-INF/views/Admin/zonas.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idParam = req.getParameter("zonaId");
        Integer id = (idParam == null || idParam.isEmpty()) ? null : Integer.parseInt(idParam);

        ZonaForestal zona = new ZonaForestal();
        if (id != null) zona.setZonaId(id);
        zona.setNombre(req.getParameter("nombre"));
        zona.setUbicacion(req.getParameter("ubicacion"));
        zona.setAreaHectareas(new java.math.BigDecimal(req.getParameter("areaHectareas")));
        zona.setTipoVegetacion(req.getParameter("tipoVegetacion"));
        zona.setCoordenadas(req.getParameter("coordenadas"));
        zona.setFechaRegistro(java.time.LocalDate.parse(req.getParameter("fechaRegistro")));

        ZonaValidator validator = new ZonaValidator();
        List<String> errores = validator.validar(zona);
        if (!errores.isEmpty()) {
            req.setAttribute("errores", errores);
            req.setAttribute("zona", zona);
            req.getRequestDispatcher("/WEB-INF/views/Admin/formZona.jsp").forward(req, resp);
            return;
        }

        if (id == null) {
            zonaService.save(zona);
        } else {
            zonaService.update(zona);
        }
        resp.sendRedirect(req.getContextPath() + "/ZonaAdmin");
    }
}