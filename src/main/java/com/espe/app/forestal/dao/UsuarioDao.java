package com.espe.app.forestal.dao;

import com.espe.app.forestal.dao.util.ConnectionBdd;
import com.espe.app.forestal.model.Usuario;
import com.espe.app.forestal.model.RolUsuario;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.Optional;

public class UsuarioDao {

    public Optional<Usuario> findByCorreo(String correo) {
        String sql = "SELECT * FROM Usuario WHERE correo = ?";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, correo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario u = mapRow(rs);
                    return Optional.of(u);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public boolean save(Usuario usuario) {
        String sql = "INSERT INTO Usuario(nombre, apellido, correo, contraseña, rol) VALUES(?,?,?,?,?)";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getCorreo());
            ps.setString(4, usuario.getContrasena());
            ps.setString(5, usuario.getRol().name());
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        usuario.setUsuarioId(keys.getInt(1));
                    }
                }
            }
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Usuario mapRow(ResultSet rs) throws SQLException {
        Usuario u = new Usuario();
        u.setUsuarioId(rs.getInt("usuario_id"));
        u.setNombre(rs.getString("nombre"));
        u.setApellido(rs.getString("apellido"));
        u.setCorreo(rs.getString("correo"));
        u.setContrasena(rs.getString("contraseña"));
        u.setRol(RolUsuario.valueOf(rs.getString("rol")));
        Timestamp ts = rs.getTimestamp("fecha_registro");
        if (ts != null) {
            u.setFechaRegistro(ts.toLocalDateTime());
        }
        return u;
    }

    public boolean update(Usuario usuario) {
        String sql = "UPDATE Usuario SET nombre=?, apellido=?, contraseña=?, rol=? WHERE usuario_id = ?";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getContrasena());
            ps.setString(4, usuario.getRol().name());
            ps.setInt(5, usuario.getUsuarioId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int usuarioId) {
        String sql = "DELETE FROM Usuario WHERE usuario_id = ?";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Optional<Usuario> findById(int usuarioId) {
        String sql = "SELECT * FROM Usuario WHERE usuario_id = ?";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }
}
