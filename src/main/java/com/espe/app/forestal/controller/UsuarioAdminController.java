// src/main/java/com/espe/app/forestal/controller/UsuarioAdminController.java
package com.espe.app.forestal.controller;

import com.espe.app.forestal.model.RolUsuario;
import com.espe.app.forestal.model.Usuario;
import com.espe.app.forestal.service.UsuarioAdminService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 * Servlet para gestionar la tabla de usuarios en el área administrativa.
 * Permite listar, crear, actualizar y eliminar usuarios.
 */
@WebServlet(name = "UsuarioAdmin", urlPatterns = {"/UsuarioAdmin"})
public class UsuarioAdminController extends HttpServlet {
    private final UsuarioAdminService usuarioService = new UsuarioAdminService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Validar que haya sesión y rol de administrador
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect(req.getContextPath() + "/Sesion.jsp");
            return;
        }
        Usuario logged = (Usuario) session.getAttribute("usuario");
        if (logged.getRol() != RolUsuario.administrador) {
            resp.sendRedirect(req.getContextPath() + "/ZonaUser");
            return;
        }

        String option = req.getParameter("option");
        if (option == null) option = "getAll";

        switch (option) {
            case "new":
                // Formulario para crear usuario
                req.getRequestDispatcher("/WEB-INF/views/Admin/formUsuario.jsp")
                   .forward(req, resp);
                break;

            case "update":
                // Cargar usuario para editar
                int idUpd = Integer.parseInt(req.getParameter("id"));
                Usuario u = usuarioService.findById(idUpd);
                if (u != null) {
                    req.setAttribute("usuario", u);
                    req.getRequestDispatcher("/WEB-INF/views/Admin/formUsuario.jsp")
                       .forward(req, resp);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/UsuarioAdmin");
                }
                break;

            case "delete":
                // Eliminar usuario
                int idDel = Integer.parseInt(req.getParameter("id"));
                usuarioService.delete(idDel);
                resp.sendRedirect(req.getContextPath() + "/UsuarioAdmin");
                break;

            default: // getAll
                // Listar todos los usuarios
                List<Usuario> lista = usuarioService.findAll();
                req.setAttribute("usuarios", lista);
                req.getRequestDispatcher("/WEB-INF/views/Admin/usuarios.jsp")
                   .forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Validar sesión y rol de administrador
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect(req.getContextPath() + "/Sesion.jsp");
            return;
        }
        Usuario logged = (Usuario) session.getAttribute("usuario");
        if (logged.getRol() != RolUsuario.administrador) {
            resp.sendRedirect(req.getContextPath() + "/ZonaUser");
            return;
        }

        // Recoger parámetros del formulario
        String idParam = req.getParameter("usuarioId");
        Integer id = (idParam == null || idParam.isEmpty()) ? null : Integer.parseInt(idParam);

        Usuario u = new Usuario();
        if (id != null) u.setUsuarioId(id);

        u.setNombre(req.getParameter("nombre"));
        u.setApellido(req.getParameter("apellido"));
        u.setCorreo(req.getParameter("correo"));
        u.setContrasena(req.getParameter("contrasena")); // texto plano, se hasheará en el service
        u.setRol(RolUsuario.valueOf(req.getParameter("rol")));

        // Guardar o actualizar
        if (id == null) {
            usuarioService.save(u);
        } else {
            usuarioService.update(u);
        }
        resp.sendRedirect(req.getContextPath() + "/UsuarioAdmin");
    }
}
