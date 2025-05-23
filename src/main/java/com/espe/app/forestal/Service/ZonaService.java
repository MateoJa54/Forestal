package com.espe.app.forestal.service;

import com.espe.app.forestal.dao.ZonaDao;
import com.espe.app.forestal.dao.EspecieDao;
import com.espe.app.forestal.model.ZonaForestal;
import com.espe.app.forestal.model.EspecieZonaDetalle;
import java.util.List;

/**
 * Service layer for Zona operations.
 */
public class ZonaService {
    private final ZonaDao zonaDao;
    private final EspecieDao especieDao;

    public ZonaService() {
        this.zonaDao = new ZonaDao();
        this.especieDao = new EspecieDao();
    }

    public List<ZonaForestal> findAll() {
        return zonaDao.findAll();
    }

    public ZonaForestal findById(int id) {
        return zonaDao.findById(id);
    }

    public void save(ZonaForestal zona) {
        zonaDao.save(zona);
    }

    public void update(ZonaForestal zona) {
        zonaDao.update(zona);
    }

    public void delete(int id) {
        zonaDao.delete(id);
    }

    public List<EspecieZonaDetalle> findEspeciesByZonaId(int zonaId) {
        return especieDao.findEspeciesByZonaId(zonaId);
    }
}