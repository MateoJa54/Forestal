package com.espe.app.forestal.dao.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionBdd {
    private static final String URL = "jdbc:mysql://localhost:3306/SistemaForestal?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    //private static final String PASSWORD = "delia1975";
    //private static final String PASSWORD = "150404";
    private static final String PASSWORD = "2704";
        
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Driver JDBC no encontrado");
            e.printStackTrace();
        }
    }

    public static Connection getConexion() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}