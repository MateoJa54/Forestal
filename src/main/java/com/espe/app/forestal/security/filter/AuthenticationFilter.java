// src/main/java/com/espe/app/forestal/security/filter/AuthenticationFilter.java
package com.espe.app.forestal.security.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    private static final String[] PUBLIC_PATHS = {
        "/Sesion.jsp", "/Auth", "/Logout", 
        "/css/", "/js/", "/images/"
    };

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest  request  = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String path = request.getRequestURI()
                     .substring(request.getContextPath().length());

        // Permitir recursos públicos
        for (String p : PUBLIC_PATHS) {
            if (path.startsWith(p)) {
                chain.doFilter(req, res);
                return;
            }
        }

        // Para todo lo demás, exigir sesión válida
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuario") != null) {
            chain.doFilter(req, res);
        } else {
            response.sendRedirect(request.getContextPath() + "/Sesion.jsp");
        }
    }

    @Override public void init(FilterConfig f) {}
    @Override public void destroy() {}
}
