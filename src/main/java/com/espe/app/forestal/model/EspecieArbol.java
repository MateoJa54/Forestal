package com.espe.app.forestal.model;
import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "Especie_Arbol")
public class EspecieArbol {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "especie_id")
    private Integer especieId;
    @Column(name = "nombre_cientifico", nullable = false, unique = true, length = 100)
    private String nombreCientifico;
    @Column(name = "nombre_comun", nullable = false, length = 100)
    private String nombreComun;
    @Column(name = "familia", length = 50)
    private String familia;
    @Enumerated(EnumType.STRING)
    @Column(name = "estado_conservacion", nullable = false, length = 20)
    private EstadoConservacion estadoConservacion;
    @Column(name = "descripcion", columnDefinition = "TEXT")
    private String descripcion;
    @Column(name = "imagen_url", length = 255)
    private String imagenUrl;
    @OneToMany(mappedBy = "especie", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<ZonaEspecie> zonas = new HashSet<>();
    public EspecieArbol() {}
    public Integer getEspecieId() { return especieId; }
    public void setEspecieId(Integer especieId) { this.especieId = especieId; }
    public String getNombreCientifico() { return nombreCientifico; }
    public void setNombreCientifico(String nombreCientifico) { this.nombreCientifico = nombreCientifico; }
    public String getNombreComun() { return nombreComun; }
    public void setNombreComun(String nombreComun) { this.nombreComun = nombreComun; }
    public String getFamilia() { return familia; }
    public void setFamilia(String familia) { this.familia = familia; }
    public EstadoConservacion getEstadoConservacion() { return estadoConservacion; }
    public void setEstadoConservacion(EstadoConservacion estadoConservacion) { this.estadoConservacion = estadoConservacion; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public String getImagenUrl() { return imagenUrl; }
    public void setImagenUrl(String imagenUrl) { this.imagenUrl = imagenUrl; }
    public Set<ZonaEspecie> getZonas() { return zonas; }
}
