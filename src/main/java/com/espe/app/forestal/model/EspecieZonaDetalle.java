package com.espe.app.forestal.model;
public class EspecieZonaDetalle {
    private int zonaId;
    private int especieId;
    private double densidad;
    private String nombreComun;
    private String nombreCientifico;
    private String zonaNombre; // nombre de la zona
    public int getZonaId() { return zonaId; }
    public void setZonaId(int zonaId) { this.zonaId = zonaId; }
    public int getEspecieId() { return especieId; }
    public void setEspecieId(int especieId) { this.especieId = especieId; }
    public double getDensidad() { return densidad; }
    public void setDensidad(double densidad) { this.densidad = densidad; }
    public String getNombreComun() { return nombreComun; }
    public void setNombreComun(String nombreComun) { this.nombreComun = nombreComun; }
    public String getNombreCientifico() { return nombreCientifico; }
    public void setNombreCientifico(String nombreCientifico) { this.nombreCientifico = nombreCientifico; }
    public String getZonaNombre() { return zonaNombre; }
    public void setZonaNombre(String zonaNombre) { this.zonaNombre = zonaNombre; }
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