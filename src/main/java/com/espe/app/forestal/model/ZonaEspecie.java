package com.espe.app.forestal.model;
import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "Zona_Especie")
public class ZonaEspecie {

    @EmbeddedId
    private ZonaEspecieId id;
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("zonaId")
    @JoinColumn(name = "zona_id")
    private ZonaForestal zona;
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("especieId")
    @JoinColumn(name = "especie_id")
    private EspecieArbol especie;
    @Column(name = "densidad", precision = 10, scale = 2)
    private BigDecimal densidad;
    public ZonaEspecie() {}
    public ZonaEspecieId getId() { return id; }
    public void setId(ZonaEspecieId id) { this.id = id; }
    public ZonaForestal getZona() { return zona; }
    public void setZona(ZonaForestal zona) { this.zona = zona; }
    public EspecieArbol getEspecie() { return especie; }
    public void setEspecie(EspecieArbol especie) { this.especie = especie; }
    public BigDecimal getDensidad() { return densidad; }
    public void setDensidad(BigDecimal densidad) { this.densidad = densidad; }
}

