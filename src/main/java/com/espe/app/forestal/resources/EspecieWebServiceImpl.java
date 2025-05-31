
package com.espe.app.forestal.resources;

import com.espe.app.forestal.dao.EspecieDao;
import com.espe.app.forestal.model.EspecieArbol;
import jakarta.jws.WebService;
import java.util.List;

/**
 *
 * @author Mateo Gabriel Criollo/OOP14575/InterByte
 */

@WebService(endpointInterface = "com.espe.app.forestal.resources.EspecieWebService")

public class EspecieWebServiceImpl implements EspecieWebService {
private final EspecieDao especieDao = new EspecieDao();

    @Override
    public List<EspecieArbol> listar() {
        return especieDao.findAll();
    }

    @Override
    public EspecieArbol buscarPorId(Long id) {
        return especieDao.findById(id.intValue());
    }

    @Override
    public boolean guardar(EspecieArbol especie) {
        return especieDao.save(especie);
    }

    @Override
    public boolean actualizar(EspecieArbol especie) {
        return especieDao.update(especie);
    }

    @Override
    public boolean eliminar(Long id) {
        return especieDao.delete(id.intValue());
    }
}
