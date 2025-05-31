
package com.espe.app.forestal.resources;

import com.espe.app.forestal.model.EspecieArbol;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.jws.WebService;
import java.util.List;


@WebService
public interface EspecieWebService {
    @WebMethod
    List<EspecieArbol> listar();

    @WebMethod
    EspecieArbol buscarPorId(@WebParam(name = "id") Long id);

    @WebMethod
    boolean guardar(@WebParam(name = "especie") EspecieArbol especie);

    @WebMethod
    boolean actualizar(@WebParam(name = "especie") EspecieArbol especie);

    @WebMethod
    boolean eliminar(@WebParam(name = "id") Long id);
}

