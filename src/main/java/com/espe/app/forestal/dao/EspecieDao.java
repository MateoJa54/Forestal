
package com.espe.app.forestal.dao;

import com.espe.app.forestal.dao.util.ConnectionBdd;
import com.espe.app.forestal.model.EspecieArbol;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author eduag
 */
public class EspecieDao {
    
   /**
 * Inserta una nueva especie de árbol en la base de datos
 * @param especie EspecieArbol a guardar
 * @return true si se guardó correctamente, false en caso contrario
 */
public boolean save(EspecieArbol especie) {
    String sql = "INSERT INTO especie_arbol (especie_id, nombre_cientifico, nombre_comun, familia, estado_conservacion, descripcion, imagen_url) VALUES (?, ?, ?, ?, ?, ?, ?)";
    try (Connection conn = ConnectionBdd.getConexion();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, especie.getEspecieId());
        stmt.setString(2, especie.getNombreCientifico());
        stmt.setString(3, especie.getNombreComun());
        stmt.setString(4, especie.getFamilia());
        //stmt.setString(5, especie.getEstadoConservacion());
        stmt.setString(6, especie.getDescripcion());
        stmt.setString(7, especie.getImagenUrl());

        return stmt.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    
     /**
     * Obtiene todas las especie_arbol
     * @return Lista de EspecieArbol
     */
     public List<EspecieArbol> findAll() {
        List<EspecieArbol> lista = new ArrayList<>();
        String sql = "SELECT * FROM especie_arbol";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                EspecieArbol e = mapRow(rs);
                lista.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
     
     /**
     * Mapea un registro ResultSet a un objeto EspecieArbol
     */
    private EspecieArbol mapRow(ResultSet rs) throws SQLException {
        EspecieArbol e = new EspecieArbol();
        e.setEspecieId(rs.getInt("especieId"));
        e.setNombreCientifico(rs.getString("nombreCientifico"));
        e.setNombreComun(rs.getString("nombreComun"));
        e.setFamilia(rs.getString("familia"));
        //e.setEstadoConservacion(rs.getString("estadoConservacion"));
        e.setDescripcion(rs.getString("descripcion"));
        e.setImagenUrl(rs.getString("ImagenUrl"));
        
        return e;
    }
}
