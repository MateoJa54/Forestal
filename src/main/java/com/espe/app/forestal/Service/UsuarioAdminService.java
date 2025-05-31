// src/main/java/com/espe/app/forestal/service/UsuarioAdminService.java
package com.espe.app.forestal.service;

import com.espe.app.forestal.dao.UsuarioDao;
import com.espe.app.forestal.dao.util.ConnectionBdd;
import com.espe.app.forestal.model.RolUsuario;
import com.espe.app.forestal.model.Usuario;
import com.espe.app.forestal.security.util.PasswordEncoder;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servicio para gestionar usuarios en el área administrativa.
 */
public class UsuarioAdminService {

    private final UsuarioDao usuarioDao;
    private final PasswordEncoder passwordEncoder;

    public UsuarioAdminService() {
        this.usuarioDao = new UsuarioDao();
        this.passwordEncoder = new PasswordEncoder();
    }

    /**
     * Obtiene la lista completa de usuarios de la base de datos.
     * Implementa directamente la consulta SQL, ya que UsuarioDao
     * no proporciona un método findAll().
     */
    public List<Usuario> findAll() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM Usuario";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setUsuarioId(rs.getInt("usuario_id"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setCorreo(rs.getString("correo"));
                u.setContrasena(rs.getString("contraseña"));
                u.setRol(RolUsuario.valueOf(rs.getString("rol")));
                java.sql.Timestamp ts = rs.getTimestamp("fecha_registro");
                if (ts != null) {
                    u.setFechaRegistro(ts.toLocalDateTime());
                }
                usuarios.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuarios;
    }

    /**
     * Busca un usuario por su ID.
     */
    public Usuario findById(int id) {
        return usuarioDao.findById(id).orElse(null);
    }

    /**
     * Crea un usuario (hashea la contraseña antes de guardar).
     */
    public boolean save(Usuario usuario) {
        String raw = usuario.getContrasena();
        usuario.setContrasena(passwordEncoder.encode(raw));
        return usuarioDao.save(usuario);
    }

    /**
     * Actualiza un usuario.
     * Si la contraseña se dejó en blanco, conserva la contraseña anterior.
     * De lo contrario, la re-hashea.
     */
    public boolean update(Usuario usuario) {
        // Si llegan contraseña vacía o null, la recuperamos del DAO
        String nuevaPass = usuario.getContrasena();
        if (nuevaPass == null || nuevaPass.isEmpty()) {
            Usuario existente = usuarioDao.findById(usuario.getUsuarioId()).orElse(null);
            if (existente != null) {
                usuario.setContrasena(existente.getContrasena());
            }
        } else {
            usuario.setContrasena(passwordEncoder.encode(nuevaPass));
        }
        return usuarioDao.update(usuario);
    }

    /**
     * Elimina un usuario por su ID.
     */
    public boolean delete(int id) {
        return usuarioDao.delete(id);
    }
}
