package com.espe.app.forestal.service;

import com.espe.app.forestal.dao.ActividadDao;
import com.espe.app.forestal.model.ActividadConservacion;
import java.util.List;

public class ActividadService {
    private final ActividadDao actividadDao;
    public ActividadService() {
        this.actividadDao = new ActividadDao();
    }
    public List<ActividadConservacion> findAll() {
        return actividadDao.findAll();
    }
    public ActividadConservacion findById(int id) {
        return actividadDao.findById(id);
    }
    public void save(ActividadConservacion actividad) {
        actividadDao.save(actividad);
    }

    public void update(ActividadConservacion actividad) {
        actividadDao.update(actividad);
    }

    public void delete(int id) {
        actividadDao.delete(id);
    }
}