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
        HttpSession session = req.getSession();

        if ("register".equals(action)) {
            // Recoge campos por separado
            String nombre   = req.getParameter("nombre");
            String apellido = req.getParameter("apellido");
            String correo   = req.getParameter("userEmail");
            String pass     = req.getParameter("userPassword");

            boolean ok = usuarioService.register(nombre, apellido, correo, pass);
            if (ok) {
                // Registro OK: iniciar sesión automático
                Optional<Usuario> opt = usuarioService.login(correo, pass);
                opt.ifPresent(u -> session.setAttribute("usuario", u));
                resp.sendRedirect(req.getContextPath() + "/Home.jsp");
            } else {
                req.setAttribute("error", "No se pudo registrar (correo ya existe)");
                req.getRequestDispatcher("/Sesion.jsp").forward(req, resp);
            }

        } else if ("login".equals(action)) {
            String correo   = req.getParameter("userEmail");
            String pass     = req.getParameter("userPassword");

            Optional<Usuario> opt = usuarioService.login(correo, pass);
            if (opt.isEmpty()) {
                // Mensaje específico para login fallido
                req.setAttribute("error", "Usuario no encontrado");
                req.getRequestDispatcher("/Sesion.jsp").forward(req, resp);
                return;
            }

            Usuario user = opt.get();
            session.setAttribute("usuario", user);

            // Redirige según rol
            if (user.getRol() == RolUsuario.administrador) {
                resp.sendRedirect(req.getContextPath() + "/homeAdministrativo.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/Home.jsp");
            }

        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción inválida");
        }
    }
}
