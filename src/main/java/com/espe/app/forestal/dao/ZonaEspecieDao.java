package com.espe.app.forestal.dao;

import com.espe.app.forestal.dao.util.ConnectionBdd;
import com.espe.app.forestal.model.ZonaEspecie;
import com.espe.app.forestal.model.ZonaEspecieId;
import com.espe.app.forestal.model.ZonaForestal;
import com.espe.app.forestal.model.EspecieArbol;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ZonaEspecieDao {

    /**
     * Devuelve todas las asociaciones ZonaEspecie para una zona dada.
     */
    public List<ZonaEspecie> findEspeciesByZona(int zonaId) {
        String sql =
            "SELECT ze.zona_id, z.nombre AS zona_nombre, " +
            "       ze.especie_id, ze.densidad, " +
            "       e.nombre_cientifico, e.nombre_comun, e.familia, " +
            "       e.estado_conservacion, e.descripcion, e.imagen_url " +
            "  FROM Zona_Especie ze " +
            "  JOIN Zona_Forestal z ON ze.zona_id = z.zona_id " +
            "  JOIN Especie_Arbol e ON ze.especie_id = e.especie_id " +
            " WHERE ze.zona_id = ?";
        List<ZonaEspecie> lista = new ArrayList<>();
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, zonaId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Clave compuesta
                    ZonaEspecieId pk = new ZonaEspecieId();
                    pk.setZonaId(rs.getInt("zona_id"));
                    pk.setEspecieId(rs.getInt("especie_id"));

                    ZonaEspecie ze = new ZonaEspecie();
                    ze.setId(pk);

                    // Mapear ZonaForestal completo (id + nombre)
                    ZonaForestal z = new ZonaForestal();
                    z.setZonaId(rs.getInt("zona_id"));
                    z.setNombre(rs.getString("zona_nombre"));
                    ze.setZona(z);

                    // Mapear EspecieArbol
                    EspecieArbol e = new EspecieArbol();
                    e.setEspecieId(rs.getInt("especie_id"));
                    e.setNombreCientifico(rs.getString("nombre_cientifico"));
                    e.setNombreComun(rs.getString("nombre_comun"));
                    e.setFamilia(rs.getString("familia"));
                    e.setEstadoConservacion(
                        com.espe.app.forestal.model.EstadoConservacion
                          .valueOf(rs.getString("estado_conservacion").toUpperCase().replace(' ', '_'))
                    );
                    e.setDescripcion(rs.getString("descripcion"));
                    e.setImagenUrl(rs.getString("imagen_url"));
                    ze.setEspecie(e);

                    // Densidad
                    ze.setDensidad(rs.getBigDecimal("densidad"));

                    lista.add(ze);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return lista;
    }

    /**
     * Devuelve todas las especies de la tabla Especie_Arbol para poblar selects.
     */
    public List<EspecieArbol> findAllEspecies() {
        return new EspecieDao().findAll();
    }

    /**
     * Inserta una asociación zona–especie con densidad.
     */
    public boolean save(int zonaId, int especieId, BigDecimal densidad) {
        String sql = "INSERT INTO Zona_Especie(zona_id, especie_id, densidad) VALUES(?, ?, ?)";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, zonaId);
            ps.setInt(2, especieId);
            ps.setBigDecimal(3, densidad);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Elimina la asociación de una especie a una zona.
     */
    public boolean delete(int zonaId, int especieId) {
        String sql = "DELETE FROM Zona_Especie WHERE zona_id = ? AND especie_id = ?";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, zonaId);
            ps.setInt(2, especieId);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }
}
