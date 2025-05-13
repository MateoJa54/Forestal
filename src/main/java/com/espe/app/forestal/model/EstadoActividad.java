
package com.espe.app.forestal.model;

public enum EstadoActividad {
    PLANEADA("Planeada"),
    EN_PROGRESO("En progreso"),
    COMPLETADA("Completada"),
    CANCELADA("Cancelada");

    private final String label;

    EstadoActividad(String label) {
        this.label = label;
    }

    @Override
    public String toString() {
        return label;
    }
}
