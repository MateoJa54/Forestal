package com.espe.app.forestal.model;

public class EspecieZonaDetalle {
    private Integer especieId;
    private String nombreCientifico;
    private String nombreComun;
    private Double densidad;

    public EspecieZonaDetalle() {
    }

    public Integer getEspecieId() {
        return especieId;
    }

    public void setEspecieId(Integer especieId) {
        this.especieId = especieId;
    }

    public String getNombreCientifico() {
        return nombreCientifico;
    }

    public void setNombreCientifico(String nombreCientifico) {
        this.nombreCientifico = nombreCientifico;
    }

    public String getNombreComun() {
        return nombreComun;
    }

    public void setNombreComun(String nombreComun) {
        this.nombreComun = nombreComun;
    }

    public Double getDensidad() {
        return densidad;
    }

    public void setDensidad(Double densidad) {
        this.densidad = densidad;
    }

    @Override
    public String toString() {
        return "EspecieZonaDetalle{" +
                "especieId=" + especieId +
                ", nombreCientifico='" + nombreCientifico + '\'' +
                ", nombreComun='" + nombreComun + '\'' +
                ", densidad=" + densidad +
                '}';
    }
}