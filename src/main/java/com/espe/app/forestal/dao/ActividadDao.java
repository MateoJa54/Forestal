package com.espe.app.forestal.dao;

import com.espe.app.forestal.dao.util.ConnectionBdd;
import com.espe.app.forestal.model.ActividadConservacion;
import com.espe.app.forestal.model.EstadoActividad;
import com.espe.app.forestal.model.ZonaForestal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActividadDao {
    
        public boolean save(ActividadConservacion actividad) {
        String sql = "INSERT INTO Actividade_Conservacion " +
                     "(nombre, descripcion, fecha_inicio, fecha_fin, presupuesto, estado, zona_id) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, actividad.getNombre());
            stmt.setString(2, actividad.getDescripcion());
            stmt.setDate(3, Date.valueOf(actividad.getFechaInicio()));
            stmt.setDate(4, Date.valueOf(actividad.getFechaFin()));
            stmt.setBigDecimal(5, actividad.getPresupuesto());
            stmt.setString(6, actividad.getEstado().name());  // Usando .name() para obtener el valor del Enum
            stmt.setInt(7, actividad.getZona().getZonaId());  // ← Aquí se establece el ID de la zona

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Obtiene todas las actividades de conservación de la base de datos
     */
    public List<ActividadConservacion> findAll() {
        List<ActividadConservacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM Actividade_Conservacion";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                lista.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    /**
     * Busca una actividad por su ID
     */
    public ActividadConservacion findById(Integer id) {
        String sql = "SELECT * FROM Actividade_Conservacion WHERE actividad_id = ?";
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
     * Actualiza una actividad existente
     */
    public boolean update(ActividadConservacion actividad) {
        String sql = "UPDATE Actividade_Conservacion SET " +
                     "nombre = ?, descripcion = ?, fecha_inicio = ?, fecha_fin = ?, presupuesto = ?, estado = ?, zona_id = ? " +
                     "WHERE actividad_id = ?";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, actividad.getNombre());
            stmt.setString(2, actividad.getDescripcion());
            stmt.setDate(3, Date.valueOf(actividad.getFechaInicio()));
            stmt.setDate(4, actividad.getFechaFin() != null ? Date.valueOf(actividad.getFechaFin()) : null);
            stmt.setBigDecimal(5, actividad.getPresupuesto());
            stmt.setString(6, actividad.getEstado().name());
            stmt.setInt(7, actividad.getZona().getZonaId());
            stmt.setInt(8, actividad.getActividadId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Elimina una actividad por su ID
     */
    public boolean delete(Integer id) {
        String sql = "DELETE FROM Actividade_Conservacion WHERE actividad_id = ?";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

        private ActividadConservacion mapRow(ResultSet rs) throws SQLException {
        ActividadConservacion actividad = new ActividadConservacion();
        actividad.setActividadId(rs.getInt("actividad_id"));
        actividad.setNombre(rs.getString("nombre"));
        actividad.setDescripcion(rs.getString("descripcion"));
        actividad.setFechaInicio(rs.getDate("fecha_inicio").toLocalDate());

        Date fechaFin = rs.getDate("fecha_fin");
        if (fechaFin != null) {
            actividad.setFechaFin(fechaFin.toLocalDate());
        }

        actividad.setPresupuesto(rs.getBigDecimal("presupuesto"));

        // 🔍 Aquí está el cambio: se obtiene el valor del estado de la BD y se convierte a Enum
        String estadoLabel = rs.getString("estado");
        if (estadoLabel != null) {
            actividad.setEstado(EstadoActividad.valueOf(estadoLabel.toUpperCase().replace(" ", "_")));
        }

        // Mapear la zona
        int zonaId = rs.getInt("zona_id");
        ZonaForestal zona = new ZonaForestal();
        zona.setZonaId(zonaId);
        actividad.setZona(zona);

        return actividad;
    }
}
