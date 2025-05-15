package com.espe.app.forestal.dao;

import com.espe.app.forestal.dao.util.ConnectionBdd;
import com.espe.app.forestal.model.EspecieZonaDetalle;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

/**
 * Clase para probar la funcionalidad de ZonaEspecieDaoJdbc
 * @author mateo
 */
public class TestZonaEspecieDaoJdbc {

    public static void main(String[] args) {
        EspecieDao zonaEspecieDao = new EspecieDao();

        // Prueba de conexión
        System.out.println("==== PRUEBA DE CONEXIÓN ====");
        try {
            Connection conn = ConnectionBdd.getConexion();
            if (conn != null && !conn.isClosed()) {
                System.out.println("Conexión exitosa a la base de datos\n");
                conn.close();
            }
        } catch (SQLException e) {
            System.err.println("Error de conexión: " + e.getMessage());
            e.printStackTrace();
            return;
        }

        // Prueba de findEspeciesByZonaId() para Zona ID 1
        pruebaFindEspeciesByZonaId(zonaEspecieDao, 10);

        // Prueba de findEspeciesByZonaId() para Zona ID 6
        pruebaFindEspeciesByZonaId(zonaEspecieDao, 6);

        // Prueba de findEspeciesByZonaId() para una Zona ID que probablemente no existe
        pruebaFindEspeciesByZonaId(zonaEspecieDao, 999);
    }

    public static void pruebaFindEspeciesByZonaId(EspecieDao dao, int zonaId) {
        System.out.println("==== PRUEBA DE FINDESPECIESBYZONAID() PARA ZONA ID " + zonaId + " ====");
        List<EspecieZonaDetalle> especiesEnZona = dao.findEspeciesByZonaId(zonaId);
        if (especiesEnZona.isEmpty()) {
            System.out.println("No se encontraron especies asociadas a la Zona Forestal con ID " + zonaId);
        } else {
            System.out.println("Especies encontradas en la Zona Forestal con ID " + zonaId + ":");
            for (EspecieZonaDetalle detalle : especiesEnZona) {
                System.out.println(String.format(
                        "- ID Especie: %d, Nombre Científico: %s, Nombre Común: %s, Densidad: %s",
                        detalle.getEspecieId(), detalle.getNombreCientifico(), detalle.getNombreComun(), detalle.getDensidad()
                ));
            }
        }
        System.out.println();
    }
}