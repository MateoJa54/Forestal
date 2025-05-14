package com.espe.app.forestal.dao;

import com.espe.app.forestal.dao.util.ConnectionBdd;
import com.espe.app.forestal.model.ActividadConservacion;
import com.espe.app.forestal.model.EstadoActividad;
import com.espe.app.forestal.model.ZonaForestal;

import java.math.BigDecimal;
import java.sql.Connection;
import java.time.LocalDate;
import java.util.List;

/**
 * Clase para probar la funcionalidad de ActividadDao
 */
public class TestActividadDao {

    public static void main(String[] args) {
        ActividadDao actividadDao = new ActividadDao();

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

        // Prueba de findAll() - Mostrar todas las actividades
        System.out.println("==== PRUEBA DE FINDALL() ====");
        List<ActividadConservacion> actividades = actividadDao.findAll();
        if (actividades.isEmpty()) {
            System.out.println("No se encontraron actividades en la base de datos");
        } else {
            System.out.println("Total de actividades encontradas: " + actividades.size());
            for (ActividadConservacion a : actividades) {
                System.out.println(String.format(
                    "ID: %d, Nombre: %s, Estado: %s, Presupuesto: %s, Zona ID: %d",
                    a.getActividadId(), a.getNombre(), a.getEstado(),
                    a.getPresupuesto().toString(), a.getZona().getZonaId()
                ));
            }
        }
        System.out.println();

        // Prueba de findById() - Buscar actividad por ID
        System.out.println("==== PRUEBA DE FINDBYID() ====");
        Integer idBuscar = actividades.isEmpty() ? 1 : actividades.get(0).getActividadId();
        ActividadConservacion actividadEncontrada = actividadDao.findById(idBuscar);
        if (actividadEncontrada != null) {
            System.out.println("Actividad encontrada con ID " + idBuscar + ":");
            System.out.println(String.format(
                "Nombre: %s, Descripción: %s, Presupuesto: %s, Estado: %s, Zona ID: %d",
                actividadEncontrada.getNombre(), actividadEncontrada.getDescripcion(),
                actividadEncontrada.getPresupuesto(), actividadEncontrada.getEstado(),
                actividadEncontrada.getZona().getZonaId()
            ));
        } else {
            System.out.println("No se encontró ninguna actividad con ID " + idBuscar);
        }
        System.out.println();

        // Opcional: Prueba de inserción
        /*
        System.out.println("==== PRUEBA DE SAVE() ====");
        ActividadConservacion nuevaActividad = new ActividadConservacion();
        nuevaActividad.setNombre("Reforestación de prueba");
        nuevaActividad.setDescripcion("Actividad de reforestación en un área específica.");
        nuevaActividad.setFechaInicio(LocalDate.now());
        nuevaActividad.setFechaFin(LocalDate.now().plusMonths(3));
        nuevaActividad.setPresupuesto(new BigDecimal("5000.00"));
        nuevaActividad.setEstado(EstadoActividad.PLANEADA);

        // Relacionar con una ZonaForestal (Reemplaza con un ID válido existente)
        ZonaForestal zona = new ZonaForestal();
        zona.setZonaId(1); // ← Asegúrate de poner un ID válido
        nuevaActividad.setZona(zona);

        boolean guardado = actividadDao.save(nuevaActividad);
        System.out.println(guardado ? "Actividad guardada exitosamente" : "Error al guardar la actividad");
        System.out.println();
        */

        // Opcional: Prueba de actualización
        /*
        System.out.println("==== PRUEBA DE UPDATE() ====");
        if (actividadEncontrada != null) {
            actividadEncontrada.setDescripcion(actividadEncontrada.getDescripcion() + " (Modificada)");
            boolean actualizado = actividadDao.update(actividadEncontrada);
            System.out.println(actualizado ? "Actividad actualizada exitosamente" : "Error al actualizar la actividad");
        }
        System.out.println();
        */

        // Opcional: Prueba de eliminación
        /*
        System.out.println("==== PRUEBA DE DELETE() ====");
        boolean eliminado = actividadDao.delete(idBuscar);
        System.out.println(eliminado ? "Actividad eliminada exitosamente" : "Error al eliminar la actividad o no existe");
        */
    }
}
