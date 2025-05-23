package com.espe.app.forestal.service;

import com.espe.app.forestal.dao.EspecieDao;
import com.espe.app.forestal.model.EspecieArbol;
import java.util.List;

/**
 * Service layer for EspecieArbol operations.
 */
public class EspecieService {
    private final EspecieDao especieDao;

    public EspecieService() {
        this.especieDao = new EspecieDao();
    }

    /**
     * Obtiene todas las especies de árbol.
     */
    public List<EspecieArbol> findAll() {
        return especieDao.findAll();
    }

    /**
     * Busca una especie por su ID.
     */
    public EspecieArbol findById(int id) {
        return especieDao.findById(id);
    }

    /**
     * Guarda una nueva especie.
     */
    public void save(EspecieArbol especie) {
        especieDao.save(especie);
    }

    /**
     * Actualiza una especie existente.
     */
    public void update(EspecieArbol especie) {
        especieDao.update(especie);
    }

    /**
     * Elimina una especie por su ID.
     */
    public void delete(int id) {
        especieDao.delete(id);
    }
}