package com.espe.app.validator;

import com.espe.app.forestal.model.ActividadConservacion;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ActividadValidator {

    public List<String> validate(ActividadConservacion actividad) {
    List<String> errors = new ArrayList<>();

    // Validación del nombre (obligatorio, longitud y debe contener letras)
    String nombre = actividad.getNombre();
    if (nombre == null || nombre.trim().isEmpty()) {
        errors.add("El nombre de la actividad es obligatorio.");
    } else {
        if (nombre.length() > 100) {
            errors.add("El nombre no debe exceder los 100 caracteres.");
        }
        if (!nombre.matches(".*[a-zA-ZáéíóúÁÉÍÓÚñÑ]+.*")) {
            errors.add("El nombre debe contener al menos una letra.");
        }
    }

    // Validación de la descripción (opcional)
    if (actividad.getDescripcion() != null && actividad.getDescripcion().length() > 500) {
        errors.add("La descripción no debe exceder los 500 caracteres.");
    }

    // Validación de fechas
    LocalDate fechaInicio = actividad.getFechaInicio();
    LocalDate fechaFin = actividad.getFechaFin();

    if (fechaInicio == null) {
        errors.add("La fecha de inicio es obligatoria.");
    }

    if (fechaFin != null && fechaInicio != null && fechaFin.isBefore(fechaInicio)) {
        errors.add("La fecha de fin no puede ser anterior a la fecha de inicio.");
    }

    // Validación del presupuesto (obligatorio y positivo)
    if (actividad.getPresupuesto() == null) {
        errors.add("El presupuesto es obligatorio.");
    } else if (actividad.getPresupuesto().doubleValue() <= 500) {
        errors.add("El presupuesto debe ser mayor que cero.");
    }

    // Validación del estado (obligatorio)
    if (actividad.getEstado() == null) {
        errors.add("El estado de la actividad es obligatorio.");
    }

    // Validación de la zona (obligatoria)
    if (actividad.getZona() == null || actividad.getZona().getZonaId() == null) {
        errors.add("Debe seleccionar una zona forestal.");
    }

    return errors;
}
}
