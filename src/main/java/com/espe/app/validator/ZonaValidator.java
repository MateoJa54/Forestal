package com.espe.app.validator;

import com.espe.app.forestal.model.ZonaForestal;
import java.util.ArrayList;
import java.util.List;

public class ZonaValidator {

    public List<String> validar(ZonaForestal zona) {
        List<String> errores = new ArrayList<>();

        if (zona.getNombre() == null || zona.getNombre().trim().isEmpty()) {
            errores.add("El nombre no puede estar vacío.");
        }
        if (zona.getUbicacion() == null || zona.getUbicacion().trim().isEmpty()) {
            errores.add("La ubicación no puede estar vacía.");
        }
        if (zona.getAreaHectareas() == null || zona.getAreaHectareas().compareTo(java.math.BigDecimal.ZERO) <= 0) {
            errores.add("El área debe ser mayor a cero.");
        }
        if (zona.getTipoVegetacion() == null || zona.getTipoVegetacion().trim().isEmpty()) {
            errores.add("El tipo de vegetación no puede estar vacío.");
        }
        if (zona.getCoordenadas() == null || zona.getCoordenadas().trim().isEmpty()) {
            errores.add("Las coordenadas no pueden estar vacías.");
        }
        if (zona.getFechaRegistro() == null) {
            errores.add("La fecha de registro es obligatoria.");
        }

        return errores;
    }
}
