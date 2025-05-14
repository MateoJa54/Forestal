package com.espe.app.forestal.dao;

import com.espe.app.forestal.dao.util.ConnectionBdd;
import com.espe.app.forestal.model.EspecieArbol;

import java.sql.Connection;
import java.util.List;

/**
 * Clase para probar la funcionalidad de EspecieDao
 * @author mateo
 */
public class TestEspecieDao {

    public static void main(String[] args) {
        EspecieDao especieDao = new EspecieDao();

        // Prueba de conexión
        System.out.println("==== PRUEBA DE CONEXIÓN ====");
        try (Connection conn = ConnectionBdd.getConexion()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("Conexión exitosa a la base de datos\n");
            }
        } catch (Exception e) {
            System.err.println("Error de conexión: " + e.getMessage());
            e.printStackTrace();
            return;
        }

        // Prueba de findAll() - Mostrar todas las especies
        System.out.println("==== PRUEBA DE FINDALL() ====");
        List<EspecieArbol> especies = especieDao.findAll();
        if (especies.isEmpty()) {
            System.out.println("No se encontraron especies en la base de datos");
        } else {
            System.out.println("Total de especies encontradas: " + especies.size());
            for (EspecieArbol e : especies) {
                System.out.println(String.format(
                    "ID: %d, Científico: %s, Común: %s, Familia: %s, Estado: %s",
                    e.getEspecieId(), e.getNombreCientifico(), e.getNombreComun(),
                    e.getFamilia(), e.getEstadoConservacion()
                ));
            }
        }
        System.out.println();

        // Prueba de findById() - Buscar especie por ID
        System.out.println("==== PRUEBA DE FINDBYID() ====");
        Integer idBuscar = especies.isEmpty() ? 1 : especies.get(0).getEspecieId();
        EspecieArbol especieEncontrada = especieDao.findById(idBuscar);
        if (especieEncontrada != null) {
            System.out.println("Especie encontrada con ID " + idBuscar + ":");
            System.out.println(String.format(
                "Científico: %s, Común: %s, Familia: %s, Estado: %s, Descripción: %s",
                especieEncontrada.getNombreCientifico(), especieEncontrada.getNombreComun(),
                especieEncontrada.getFamilia(), especieEncontrada.getEstadoConservacion(),
                especieEncontrada.getDescripcion()
            ));
        } else {
            System.out.println("No se encontró ninguna especie con ID " + idBuscar);
        }
        System.out.println();

        // Opcional: Prueba de inserción
        /*
        System.out.println("==== PRUEBA DE SAVE() ====");
        EspecieArbol nueva = new EspecieArbol();
        nueva.setNombreCientifico("Testus arborus");
        nueva.setNombreComun("Árbol Test");
        nueva.setFamilia("Familia Test");
        nueva.setEstadoConservacion(EstadoConservacion.ESTABLE);
        nueva.setDescripcion("Descripción de prueba");
        nueva.setImagenUrl("http://example.com/img.jpg");
        boolean guardado = especieDao.save(nueva);
        System.out.println(guardado ? "Especie guardada exitosamente" : "Error al guardar la especie");
        System.out.println();
        */

        // Opcional: Prueba de actualización
        /*
        System.out.println("==== PRUEBA DE UPDATE() ====");
        if (especieEncontrada != null) {
            especieEncontrada.setNombreComun(especieEncontrada.getNombreComun() + " Mod");
            boolean actualizado = especieDao.update(especieEncontrada);
            System.out.println(actualizado ? "Especie actualizada exitosamente" : "Error al actualizar la especie");
        }
        System.out.println();
        */

        // Opcional: Prueba de eliminación
        /*
        System.out.println("==== PRUEBA DE DELETE() ====");
        boolean eliminado = especieDao.delete(idBuscar);
        System.out.println(eliminado ? "Especie eliminada exitosamente" : "Error al eliminar la especie o no existe");
        */
    }
}
