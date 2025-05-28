// src/main/java/com/espe/app/forestal/controller/LogoutServlet.java
package com.espe.app.forestal.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name="LogoutServlet", urlPatterns={"/Logout"})
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();  // limpia todo
        }
        resp.sendRedirect(req.getContextPath() + "/Sesion.jsp");
    }
}
