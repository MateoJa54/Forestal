package com.espe.app.forestal.dao;

import com.espe.app.forestal.dao.util.ConnectionBdd;
import com.espe.app.forestal.model.Usuario;

import java.sql.Connection;
import java.util.List;
import java.util.Optional;

public class TestUsuarioDao {
    public static void main(String[] args) {
        UsuarioDao dao = new UsuarioDao();

        // Prueba conexión
        System.out.println("==== PRUEBA DE CONEXIÓN A BD ====");
        try (Connection conn = ConnectionBdd.getConexion()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("Conexión exitosa");
            }
        } catch (Exception e) {
            System.err.println("Error de conexión: " + e.getMessage());
            e.printStackTrace();
            return;
        }

        // Prueba de registro
        System.out.println("==== PRUEBA DE SAVE() ====");
        Usuario newUser = new Usuario();
        newUser.setNombre("Test");
        newUser.setApellido("User");
        newUser.setCorreo("testuser@example.com");
        newUser.setContrasena("$2a$10$7EqJtq98hPqEX7fNZaFWoO8F9adf6vw8lKpXJlZcT1yEwT7iODZi6"); // hash de 'password'
        newUser.setRol(com.espe.app.forestal.model.RolUsuario.usuario);
        boolean saved = dao.save(newUser);
        System.out.println("Usuario guardado: " + saved + ", ID generado: " + newUser.getUsuarioId());

        // Prueba findByCorreo
        System.out.println("==== PRUEBA DE findByCorreo() ====");
        Optional<Usuario> opt = dao.findByCorreo("testuser@example.com");
        if (opt.isPresent()) {
            Usuario u = opt.get();
            System.out.println("Email encontrado: " + u.getCorreo() + ", Rol: " + u.getRol());
        } else {
            System.out.println("No encontrado por correo");
        }

        // Prueba findById
        System.out.println("==== PRUEBA DE findById() ====");
        Optional<Usuario> optId = dao.findById(newUser.getUsuarioId());
        System.out.println(optId.isPresent() ? "Usuario con ID existe" : "No existe usuario con ID");

        // Prueba delete
        System.out.println("==== PRUEBA DE delete() ====");
        boolean deleted = dao.delete(newUser.getUsuarioId());
        System.out.println("Usuario eliminado: " + deleted);
    }
}