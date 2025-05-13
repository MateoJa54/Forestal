package com.espe.app.forestal.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "Zona_Forestal")
public class ZonaForestal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "zona_id")
    private Integer zonaId;

    @Column(name = "nombre", nullable = false, length = 100)
    private String nombre;

    @Column(name = "ubicacion", nullable = false, length = 200)
    private String ubicacion;

    @Column(name = "area_hectareas", precision = 10, scale = 2)
    private BigDecimal areaHectareas;

    @Column(name = "tipo_vegetacion", length = 50)
    private String tipoVegetacion;

    @Column(name = "coordenadas", length = 100)
    private String coordenadas;

    @Column(name = "fecha_registro")
    private LocalDate fechaRegistro;

    @OneToMany(mappedBy = "zona", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<ActividadConservacion> actividades = new HashSet<>();

    @OneToMany(mappedBy = "zona", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<ZonaEspecie> especies = new HashSet<>();

    public ZonaForestal() {}

    // getters y setters
    public Integer getZonaId() { return zonaId; }
    public void setZonaId(Integer zonaId) { this.zonaId = zonaId; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getUbicacion() { return ubicacion; }
    public void setUbicacion(String ubicacion) { this.ubicacion = ubicacion; }

    public BigDecimal getAreaHectareas() { return areaHectareas; }
    public void setAreaHectareas(BigDecimal areaHectareas) { this.areaHectareas = areaHectareas; }

    public String getTipoVegetacion() { return tipoVegetacion; }
    public void setTipoVegetacion(String tipoVegetacion) { this.tipoVegetacion = tipoVegetacion; }

    public String getCoordenadas() { return coordenadas; }
    public void setCoordenadas(String coordenadas) { this.coordenadas = coordenadas; }

    public LocalDate getFechaRegistro() { return fechaRegistro; }
    public void setFechaRegistro(LocalDate fechaRegistro) { this.fechaRegistro = fechaRegistro; }

    public Set<ActividadConservacion> getActividades() { return actividades; }
    public Set<ZonaEspecie> getEspecies() { return especies; }
}
