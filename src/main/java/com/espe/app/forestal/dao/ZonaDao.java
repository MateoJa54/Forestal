
package com.espe.app.forestal.dao;
import com.espe.app.forestal.dao.util.ConnectionBdd;
import com.espe.app.forestal.model.ZonaForestal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class ZonaDao {

    /**
     * Inserta una nueva zona forestal en la base de datos
     * @param zona ZonaForestal a guardar
     * @return true si se guardó correctamente, false en caso contrario
     */
    public boolean save(ZonaForestal zona) {
        String sql = "INSERT INTO Zona_Forestal (nombre, ubicacion, area_hectareas, tipo_vegetacion, coordenadas, fecha_registro) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, zona.getNombre());
            stmt.setString(2, zona.getUbicacion());
            stmt.setBigDecimal(3, zona.getAreaHectareas());
            stmt.setString(4, zona.getTipoVegetacion());
            stmt.setString(5, zona.getCoordenadas());
            stmt.setDate(6, Date.valueOf(zona.getFechaRegistro()));

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Obtiene todas las zonas forestales
     * @return Lista de ZonaForestal
     */
    public List<ZonaForestal> findAll() {
        List<ZonaForestal> lista = new ArrayList<>();
        String sql = "SELECT * FROM Zona_Forestal";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ZonaForestal z = mapRow(rs);
                lista.add(z);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    /**
     * Busca una zona por su ID
     * @param id ID de la zona
     * @return ZonaForestal o null si no existe
     */
    public ZonaForestal findById(Integer id) {
        String sql = "SELECT * FROM Zona_Forestal WHERE zona_id = ?";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Actualiza una zona existente
     * @param zona ZonaForestal con datos actualizados
     * @return true si se actualizó correctamente, false en caso contrario
     */
    public boolean update(ZonaForestal zona) {
        String sql = "UPDATE Zona_Forestal SET nombre = ?, ubicacion = ?, area_hectareas = ?, tipo_vegetacion = ?, coordenadas = ?, fecha_registro = ? WHERE zona_id = ?";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, zona.getNombre());
            stmt.setString(2, zona.getUbicacion());
            stmt.setBigDecimal(3, zona.getAreaHectareas());
            stmt.setString(4, zona.getTipoVegetacion());
            stmt.setString(5, zona.getCoordenadas());
            stmt.setDate(6, Date.valueOf(zona.getFechaRegistro()));
            stmt.setInt(7, zona.getZonaId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Elimina una zona por su ID
     * @param id ID de la zona a eliminar
     * @return true si se eliminó correctamente, false en caso contrario
     */
    public boolean delete(Integer id) {
        String sql = "DELETE FROM Zona_Forestal WHERE zona_id = ?";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Mapea un registro ResultSet a un objeto ZonaForestal
     */
    private ZonaForestal mapRow(ResultSet rs) throws SQLException {
        ZonaForestal z = new ZonaForestal();
        z.setZonaId(rs.getInt("zona_id"));
        z.setNombre(rs.getString("nombre"));
        z.setUbicacion(rs.getString("ubicacion"));
        z.setAreaHectareas(rs.getBigDecimal("area_hectareas"));
        z.setTipoVegetacion(rs.getString("tipo_vegetacion"));
        z.setCoordenadas(rs.getString("coordenadas"));
        Date fecha = rs.getDate("fecha_registro");
        if (fecha != null) {
            z.setFechaRegistro(fecha.toLocalDate());
        }
        return z;
    }
}
