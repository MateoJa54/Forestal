
package com.espe.app.forestal.model;

public enum EstadoConservacion {
    EN_PELIGRO("En peligro"),
    VULNERABLE("Vulnerable"),
    ESTABLE("Estable"),
    CASI_AMENAZADA("Casi amenazada"),
    EXTINTA("Extinta");

    private final String label;

    EstadoConservacion(String label) {
        this.label = label;
    }

    @Override
    public String toString() {
        return label;
    }
}
