
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ZonaEspecieId)) return false;
        ZonaEspecieId that = (ZonaEspecieId) o;
        return getZonaId().equals(that.getZonaId()) && getEspecieId().equals(that.getEspecieId());
    }

    @Override
    public int hashCode() {
        return getZonaId().hashCode() + getEspecieId().hashCode();
    }

    /**
     * @return the zonaId
     */
    public Integer getZonaId() {
        return zonaId;
    }

    /**
     * @param zonaId the zonaId to set
     */
    public void setZonaId(Integer zonaId) {
        this.zonaId = zonaId;
    }

    /**
     * @return the especieId
     */
    public Integer getEspecieId() {
        return especieId;
    }

    /**
     * @param especieId the especieId to set
     */
    public void setEspecieId(Integer especieId) {
        this.especieId = especieId;
    }
}