package com.espe.app.forestal.service;

import com.espe.app.forestal.dao.ZonaEspecieDao;
import com.espe.app.forestal.model.ZonaEspecie;
import com.espe.app.forestal.model.EspecieZonaDetalle;
import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service layer for Zona-Especie associations.
 */
public class ZonaEspecieService {
    private final ZonaEspecieDao zeDao;

    public ZonaEspecieService() {
        this.zeDao = new ZonaEspecieDao();
    }

    /**
     * Obtiene todas las asociaciones completas para una zona.
     */
    public List<ZonaEspecie> findByZona(int zonaId) {
        return zeDao.findEspeciesByZona(zonaId);
    }

    /**
     * Obtiene el detalle DTO de especies por zona.
     */
    public List<EspecieZonaDetalle> getDetalleByZona(int zonaId) {
        List<ZonaEspecie> entities = zeDao.findEspeciesByZona(zonaId);
        return entities.stream().map(ze -> {
            EspecieZonaDetalle dto = new EspecieZonaDetalle();
            dto.setZonaId(ze.getZona().getZonaId());
            dto.setZonaNombre(ze.getZona().getNombre());
            dto.setEspecieId(ze.getEspecie().getEspecieId());
            dto.setNombreComun(ze.getEspecie().getNombreComun());
            dto.setNombreCientifico(ze.getEspecie().getNombreCientifico());
            dto.setDensidad(ze.getDensidad().doubleValue());
            return dto;
        }).collect(Collectors.toList());
    }

    /**
     * Crea una nueva asociación zona-especie.
     */
    public void save(int zonaId, int especieId, BigDecimal densidad) {
        zeDao.save(zonaId, especieId, densidad);
    }

    /**
     * Elimina una asociación zona-especie.
     */
    public void delete(int zonaId, int especieId) {
        zeDao.delete(zonaId, especieId);
    }
}