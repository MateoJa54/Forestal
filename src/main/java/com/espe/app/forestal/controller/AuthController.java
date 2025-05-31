// src/main/java/com/espe/app/forestal/controller/AuthController.java
package com.espe.app.forestal.controller;

import com.espe.app.forestal.model.Usuario;
import com.espe.app.forestal.model.RolUsuario;
import com.espe.app.forestal.service.UsuarioService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "AuthController", urlPatterns = {"/Auth"})
public class AuthController extends HttpServlet {
    private final UsuarioService usuarioService = new UsuarioService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        HttpSession session = req.getSession(true);

        if ("register".equals(action)) {
            // Registro de usuario normal (los admins se crean por separado)
            String nombre   = req.getParameter("nombre");
            String apellido = req.getParameter("apellido");
            String correo   = req.getParameter("userEmail");
            String pass     = req.getParameter("userPassword");

            boolean ok = usuarioService.register(nombre, apellido, correo, pass);
            if (ok) {
                // Iniciar sesión automático
                Optional<Usuario> opt = usuarioService.login(correo, pass);
                if (opt.isPresent()) {
                    Usuario u = opt.get();
                    session.setAttribute("usuario", u);
                    // Redirigir según rol (aunque aquí siempre será 'usuario')
                    resp.sendRedirect(req.getContextPath()
                        + (u.getRol() == RolUsuario.administrador
                            ? "/ZonaAdmin"
                            : "/Home"));
                } else {
                    // raro, pero por si falla el login automático
                    resp.sendRedirect(req.getContextPath() + "/Sesion.jsp");
                }
            } else {
                req.setAttribute("error", "No se pudo registrar (correo ya existe)");
                req.getRequestDispatcher("/Sesion.jsp").forward(req, resp);
            }

        } else if ("login".equals(action)) {
            // Inicio de sesión
            String correo   = req.getParameter("userEmail");
            String pass     = req.getParameter("userPassword");

            Optional<Usuario> opt = usuarioService.login(correo, pass);
            if (opt.isEmpty()) {
                req.setAttribute("error", "Usuario no encontrado");
                req.getRequestDispatcher("/Sesion.jsp").forward(req, resp);
                return;
            }

            Usuario user = opt.get();
            session.setAttribute("usuario", user);

            // Redirigir de inmediato al área correspondiente
            if (user.getRol() == RolUsuario.administrador) {
                resp.sendRedirect(req.getContextPath() + "/ZonaAdmin");
            } else {
                resp.sendRedirect(req.getContextPath() + "/Home");
            }

        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción inválida");
        }
    }
}
