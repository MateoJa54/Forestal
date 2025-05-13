
package com.espe.app.forestal.model;
import jakarta.persistence.*;

@Embeddable
public class ZonaEspecieId implements java.io.Serializable {

    @Column(name = "zona_id")
    private Integer zonaId;

    @Column(name = "especie_id")
    private Integer especieId;

    public ZonaEspecieId() {}

    public ZonaEspecieId(Integer zonaId, Integer especieId) {
        this.zonaId = zonaId;
        this.especieId = especieId;
    }

    // equals y hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ZonaEspecieId)) return false;
        ZonaEspecieId that = (ZonaEspecieId) o;
        return zonaId.equals(that.zonaId) && especieId.equals(that.especieId);
    }

    @Override
    public int hashCode() {
        return zonaId.hashCode() + especieId.hashCode();
    }
}