
package com.espe.app.forestal;

/**
 *
 * @author Mateo Gabriel Criollo/OOP14575/InterByte
 */
import com.espe.app.forestal.resources.EspecieWebServiceImpl;
import jakarta.xml.ws.Endpoint;

public class Publicador {
    public static void main(String[] args) {
        Endpoint.publish("http://192.168.18.12/EspecieWebService", new EspecieWebServiceImpl());
        System.out.println("Servicio publicado en http://192.168.18.12/EspecieWebService");
    }
}

