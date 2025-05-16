package com.espe.app.validator;

import com.espe.app.forestal.model.EspecieArbol;
import java.util.ArrayList;
import java.util.List;

public class EspecieValidator {

    public List<String> validar(EspecieArbol especie) {
        List<String> errores = new ArrayList<>();

        // Validar nombre científico
        if (especie.getNombreCientifico() == null || especie.getNombreCientifico().trim().isEmpty()) {
            errores.add("El nombre científico es obligatorio.");
        } else if (!especie.getNombreCientifico().matches("^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$")) {
            errores.add("El nombre científico solo debe contener letras y espacios.");
        }

        // Validar nombre común
        if (especie.getNombreComun() == null || especie.getNombreComun().trim().isEmpty()) {
            errores.add("El nombre común es obligatorio.");
        } else if (!especie.getNombreComun().matches("^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$")) {
            errores.add("El nombre común solo debe contener letras y espacios.");
        }

        // Validar familia
        if (especie.getFamilia() == null || especie.getFamilia().trim().isEmpty()) {
            errores.add("La familia es obligatoria.");
        } else if (!especie.getFamilia().matches("^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$")) {
            errores.add("La familia solo debe contener letras y espacios.");
        }

        // Validar estado de conservación
        if (especie.getEstadoConservacion() == null) {
            errores.add("El estado de conservación es obligatorio.");
        }

        return errores;
    }
}