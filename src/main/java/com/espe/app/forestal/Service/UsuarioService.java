package com.espe.app.forestal.service;

import com.espe.app.forestal.dao.UsuarioDao;
import com.espe.app.forestal.model.Usuario;
import java.util.Optional;

public class UsuarioService {
    private final UsuarioDao usuarioDao;

    public UsuarioService() {
        this.usuarioDao = new UsuarioDao();
    }

    public Optional<Usuario> findByCorreo(String correo) {
        return usuarioDao.findByCorreo(correo);
    }

    public boolean register(Usuario usuario) {
        return usuarioDao.save(usuario);
    }

    public Optional<Usuario> findById(int id) {
        return usuarioDao.findById(id);
    }

    public boolean update(Usuario usuario) {
        return usuarioDao.update(usuario);
    }

    public boolean delete(int id) {
        return usuarioDao.delete(id);
    }
}