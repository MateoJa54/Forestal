// src/main/java/com/espe/app/forestal/security/filter/AuthenticationFilter.java
package com.espe.app.forestal.security.filter;

import com.espe.app.forestal.model.Usuario;
import com.espe.app.forestal.model.RolUsuario;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    // Rutas que pueden verse sin iniciar sesión o para logout
    private static final String[] PUBLIC_PATHS = {
        "/Sesion.jsp",   // página de login/registro
        "/Auth",         // servlet de login/registro
        "/Logout",       // servlet de cierre de sesión
        "/css/",         // recursos estáticos (CSS, JS, imágenes)
        "/js/",
        "/images/"
    };

    // Rutas “administrativas”: solo las puede ver RolUsuario.administrador
    private static final String[] ADMIN_PATHS = {
        "/ZonaAdmin",
        "/EspecieAdmin",
        "/ActividadAdmin",
        "/ZonaEspecieAdmin"
        // (Si tienes otros endpoints admin, agrégalos aquí)
    };

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest  request  = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        // Obtiene el path dentro del contexto (por ejemplo: "/ZonaUser" o "/css/style.css")
        String path = request.getRequestURI()
                       .substring(request.getContextPath().length());

        // 1) Si la solicitud coincide con alguna ruta pública, dejamos pasar
        for (String publicPath : PUBLIC_PATHS) {
            if (path.startsWith(publicPath)) {
                chain.doFilter(req, res);
                return;
            }
        }

        // 2) Verificamos que haya sesión y atributo "usuario"
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            // No hay usuario en sesión → redirigir a login
            response.sendRedirect(request.getContextPath() + "/Sesion.jsp");
            return;
        }

        // 3) Ya hay usuario: extraemos su rol
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        RolUsuario rol   = usuario.getRol();

        // 4) Si la ruta solicitada es de tipo “admin”, comprobamos el rol
        for (String adminPath : ADMIN_PATHS) {
            if (path.startsWith(adminPath)) {
                // Usuario normal tratando de acceder a ruta admin → prohibido
                if (rol != RolUsuario.administrador) {
                    // Redirigir a su vista de usuario (o mostrar 403)
                    response.sendRedirect(request.getContextPath() + "/ZonaUser");
                    return;
                }
                // Si sí es administrador, continúa normalmente
                break;
            }
        }

        // 5) Si no coincide con rutas públicas ni admin-protegidas, autorizamos
        chain.doFilter(req, res);
    }

    @Override
    public void init(FilterConfig filterConfig) { /* No hace falta init */ }
    @Override
    public void destroy()    { /* No hace falta destroy */ }
}
