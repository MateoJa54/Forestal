
package com.espe.app.forestal.dao;
import com.espe.app.forestal.dao.util.ConnectionBdd;
import com.espe.app.forestal.model.ZonaForestal;
import java.util.List;
import java.sql.Connection;

/**
 * Clase para probar la funcionalidad de ZonaDao
 * @author mateo
 */
public class TestZonaDao {

    public static void main(String[] args) {
        ZonaDao zonaDao = new ZonaDao();

        // Prueba de conexión
        System.out.println("==== PRUEBA DE CONEXIÓN ====");
        try {
            Connection conn = ConnectionBdd.getConexion();
            if (conn != null && !conn.isClosed()) {
                System.out.println("Conexión exitosa a la base de datos\n");
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("Error de conexión: " + e.getMessage());
            e.printStackTrace();
            return;
        }

        // Prueba de findAll() - Mostrar todas las zonas
        System.out.println("==== PRUEBA DE FINDALL() ====");
        List<ZonaForestal> zonas = zonaDao.findAll();
        if (zonas.isEmpty()) {
            System.out.println("No se encontraron zonas en la base de datos");
        } else {
            System.out.println("Total de zonas encontradas: " + zonas.size());
            for (ZonaForestal z : zonas) {
                System.out.println(String.format(
                    "ID: %d, Nombre: %s, Ubicación: %s, Área: %s ha, Registro: %s",
                    z.getZonaId(), z.getNombre(), z.getUbicacion(), z.getAreaHectareas(), z.getFechaRegistro()
                ));
            }
        }
        System.out.println();

        // Prueba de findById() - Buscar zona por ID
        System.out.println("==== PRUEBA DE FINDBYID() ====");
        Integer idBuscar = zonas.isEmpty() ? 1 : zonas.get(0).getZonaId(); // prueba con el primer ID
        ZonaForestal zonaEncontrada = zonaDao.findById(idBuscar);
        if (zonaEncontrada != null) {
            System.out.println("Zona encontrada con ID " + idBuscar + ":");
            System.out.println(String.format(
                "Nombre: %s, Ubicación: %s, Área: %s ha, Registro: %s",
                zonaEncontrada.getNombre(), zonaEncontrada.getUbicacion(), zonaEncontrada.getAreaHectareas(), zonaEncontrada.getFechaRegistro()
            ));
        } else {
            System.out.println("No se encontró ninguna zona con ID " + idBuscar);
        }
        System.out.println();

        // Opcional: Prueba de inserción
        /*
        System.out.println("==== PRUEBA DE SAVE() ====");
        ZonaForestal nuevaZona = new ZonaForestal();
        nuevaZona.setNombre("Zona Prueba");
        nuevaZona.setUbicacion("Ubicación Prueba");
        nuevaZona.setAreaHectareas(new java.math.BigDecimal("12.34"));
        nuevaZona.setTipoVegetacion("Bosque mixto");
        nuevaZona.setCoordenadas("0.000,0.000");
        nuevaZona.setFechaRegistro(java.time.LocalDate.now());
        boolean guardado = zonaDao.save(nuevaZona);
        System.out.println(guardado ? "Zona guardada exitosamente" : "Error al guardar la zona");
        System.out.println();
        */

        // Opcional: Prueba de actualización
        /*
        System.out.println("==== PRUEBA DE UPDATE() ====");
        if (zonaEncontrada != null) {
            zonaEncontrada.setNombre(zonaEncontrada.getNombre() + " Modificada");
            boolean actualizado = zonaDao.update(zonaEncontrada);
            System.out.println(actualizado ? "Zona actualizada exitosamente" : "Error al actualizar la zona");
        }
        System.out.println();
        */

        // Opcional: Prueba de eliminación
        /*
        System.out.println("==== PRUEBA DE DELETE() ====");
        boolean eliminado = zonaDao.delete(idBuscar);
        System.out.println(eliminado ? "Zona eliminada exitosamente" : "Error al eliminar la zona o no existe");
        */
    }
}
