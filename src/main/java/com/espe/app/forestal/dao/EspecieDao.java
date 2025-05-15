package com.espe.app.forestal.dao;

import com.espe.app.forestal.dao.util.ConnectionBdd;
import com.espe.app.forestal.model.EspecieArbol;
import com.espe.app.forestal.model.EstadoConservacion;
import com.espe.app.forestal.model.EspecieZonaDetalle;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EspecieDao {

    /**
     * Inserta una nueva especie de árbol en la base de datos
     */
    public boolean save(EspecieArbol especie) {
        String sql = "INSERT INTO Especie_Arbol " +
                     "(nombre_cientifico, nombre_comun, familia, estado_conservacion, descripcion, imagen_url) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, especie.getNombreCientifico());
            stmt.setString(2, especie.getNombreComun());
            stmt.setString(3, especie.getFamilia());
            stmt.setString(4, especie.getEstadoConservacion().toString());
            stmt.setString(5, especie.getDescripcion());
            stmt.setString(6, especie.getImagenUrl());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Obtiene todas las especies de la base de datos
     */
    public List<EspecieArbol> findAll() {
        List<EspecieArbol> lista = new ArrayList<>();
        String sql = "SELECT * FROM Especie_Arbol";
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
     * Busca una especie por su ID
     */
    public EspecieArbol findById(Integer id) {
        String sql = "SELECT * FROM Especie_Arbol WHERE especie_id = ?";
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
     * Actualiza una especie existente
     */
    public boolean update(EspecieArbol especie) {
        String sql = "UPDATE Especie_Arbol SET " +
                     "nombre_cientifico = ?, nombre_comun = ?, familia = ?, estado_conservacion = ?, descripcion = ?, imagen_url = ? " +
                     "WHERE especie_id = ?";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, especie.getNombreCientifico());
            stmt.setString(2, especie.getNombreComun());
            stmt.setString(3, especie.getFamilia());
            stmt.setString(4, especie.getEstadoConservacion().toString());
            stmt.setString(5, especie.getDescripcion());
            stmt.setString(6, especie.getImagenUrl());
            stmt.setInt(7, especie.getEspecieId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Elimina una especie por su ID
     */
    public boolean delete(Integer id) {
        String sql = "DELETE FROM Especie_Arbol WHERE especie_id = ?";
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
     * Mapea un registro ResultSet a un objeto EspecieArbol
     */
    private EspecieArbol mapRow(ResultSet rs) throws SQLException {
        EspecieArbol e = new EspecieArbol();
        e.setEspecieId(rs.getInt("especie_id"));
        e.setNombreCientifico(rs.getString("nombre_cientifico"));
        e.setNombreComun(rs.getString("nombre_comun"));
        e.setFamilia(rs.getString("familia"));

        // Mapear estado_conservacion comparando etiquetas
        String estadoLabel = rs.getString("estado_conservacion");
        for (EstadoConservacion ec : EstadoConservacion.values()) {
            if (ec.toString().equals(estadoLabel)) {
                e.setEstadoConservacion(ec);
                break;
            }
        }

        e.setDescripcion(rs.getString("descripcion"));
        e.setImagenUrl(rs.getString("imagen_url"));
        return e;
    }
    
      /**
     * Obtiene las especies asociadas a un ID de Zona Forestal.
     * @param zonaId ID de la zona forestal.
     * @return Lista de EspecieZonaDetalle con la información de las especies y su densidad.
     */
    public List<EspecieZonaDetalle> findEspeciesByZonaId(Integer zonaId) {
        List<EspecieZonaDetalle> lista = new ArrayList<>();
        String sql = "SELECT " +
                     "    ea.especie_id, " +
                     "    ea.nombre_cientifico, " +
                     "    ea.nombre_comun, " +
                     "    ze.densidad " +
                     "FROM Especie_Arbol ea " +
                     "INNER JOIN Zona_Especie ze " +
                     "    ON ea.especie_id = ze.especie_id " +
                     "WHERE " +
                     "    ze.zona_id = ?";

        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, zonaId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    EspecieZonaDetalle detalle = mapRowEspecieZonaDetalle(rs);
                    lista.add(detalle);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    /**
     * Mapea un registro ResultSet a un objeto EspecieArbol
     */
    public EspecieArbol mapRowEspecieArbol(ResultSet rs) throws SQLException {
        EspecieArbol e = new EspecieArbol();
        e.setEspecieId(rs.getInt("especie_id"));
        e.setNombreCientifico(rs.getString("nombre_cientifico"));
        e.setNombreComun(rs.getString("nombre_comun"));
        e.setFamilia(rs.getString("familia"));

        // Mapear estado_conservacion comparando etiquetas
        String estadoLabel = rs.getString("estado_conservacion");
        for (EstadoConservacion ec : EstadoConservacion.values()) {
            if (ec.toString().equals(estadoLabel)) {
                e.setEstadoConservacion(ec);
                break;
            }
        }

        e.setDescripcion(rs.getString("descripcion"));
        e.setImagenUrl(rs.getString("imagen_url"));
        return e;
    }

    /**
     * Mapea un registro ResultSet a un objeto EspecieZonaDetalle.
     */
    public EspecieZonaDetalle mapRowEspecieZonaDetalle(ResultSet rs) throws SQLException {
        EspecieZonaDetalle detalle = new EspecieZonaDetalle();
        detalle.setEspecieId(rs.getInt("especie_id"));
        detalle.setNombreCientifico(rs.getString("nombre_cientifico"));
        detalle.setNombreComun(rs.getString("nombre_comun"));
        detalle.setDensidad(rs.getDouble("densidad"));
        return detalle;
    }
}
