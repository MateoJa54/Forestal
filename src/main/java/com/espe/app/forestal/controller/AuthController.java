package com.espe.app.forestal.controller;

import com.espe.app.forestal.model.Usuario;
import com.espe.app.forestal.model.RolUsuario;
import com.espe.app.forestal.service.UsuarioService;
import com.espe.app.forestal.security.util.PasswordEncoder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "AuthController", urlPatterns = {"/Auth"})
public class AuthController extends HttpServlet {
    private final UsuarioService usuarioService = new UsuarioService();
    private final PasswordEncoder passwordEncoder = new PasswordEncoder();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String correo = req.getParameter("correo");
        String clave = req.getParameter("contrasena");
        Optional<Usuario> optUser = usuarioService.findByCorreo(correo);
        if (optUser.isEmpty() || !passwordEncoder.matches(clave, optUser.get().getContrasena())) {
            req.setAttribute("error", "Credenciales inválidas");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }
        Usuario user = optUser.get();
        HttpSession session = req.getSession(true);
        session.setAttribute("usuario", user);
        session.setAttribute("rol", user.getRol().name());
        if (user.getRol() == RolUsuario.administrador) {
            resp.sendRedirect(req.getContextPath() + "/Zona");
        } else {
            resp.sendRedirect(req.getContextPath() + "/VistaUsuario");
        }
    }
}