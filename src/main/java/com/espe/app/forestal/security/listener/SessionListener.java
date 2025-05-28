// src/main/java/com/espe/app/forestal/security/listener/SessionListener.java
package com.espe.app.forestal.security.listener;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.*;

@WebListener
public class SessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        // Opcional: puedes registrar la creación
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        // Aquí podrías limpiar recursos o hacer logging
        HttpSession session = se.getSession();
        // Ej: System.out.println("Sesión expirada para usuario: " + session.getAttribute("usuario"));
    }
}
